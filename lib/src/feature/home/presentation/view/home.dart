import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lifecycle_detector/flutter_lifecycle_detector.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/location_access/location_access_page.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/shimmer_widget.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/usecase/get_home_view_details.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/save_local_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/widgets/categories_horizontal_list_view.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_card_view.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/item_list_tile_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/tabs/chat_tab.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/tabs/explore_tab.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/tabs/favorites_tab.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/tabs/home_tab.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/tabs/profile_tab.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

int c = 0;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routePath = "/home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // FlutterLifecycleDetector().onBackgroundChange.listen((isBackground) {
    //   /// `isBackground` is true => background
    //   /// `isBackground` is false => foreground
    //   print('Status background $isBackground');
    //   context
    //       .read<HomeViewBloc>()
    //       .add(SavingFavouritesEvent(params: AppData.favouriteModel));
    // });

    if (c <= 1) {
      c += 1;
      counter = 0;
      context.read<HomeViewBloc>().add(
          FetchingStudioDataEvent(params: AllParams(location: user.location)));
    }
    super.initState();
    socket = connect();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(state) async {
    if (state == AppLifecycleState.detached) {
      print('detaachedddd');

      log(AppData.favouriteModel.toString());
    }
  }

  IO.Socket connect() {
    final socket = IO.io("${AppRequestUrl.baseUrl}/", {
      'transports': ['websocket'],
      'autoConnect': false,
    });

    if (!socket.connected) {
      socket.connect();
      socket.onConnect((data) {
        socket.emit('user', user.uuid);
        log('connected', name: "SOCKET");
      });
      socket.onConnectError((_) {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Text(_.toString()),
                ));
      });
    }
    // log(socket.connected.toString(),name: );

    return socket;
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 4, spreadRadius: 0, color: colorScheme.surface)
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        height: 82,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavItem(0, "Home", ImageAssets.home),
              buildNavItem(1, "Explore", ImageAssets.explore),
              buildNavItem(2, "Favorite", ImageAssets.favorite),
              buildNavItem(3, "Chat", ImageAssets.chat),
              buildNavItem(4, "Profile", ImageAssets.profile),
            ],
          ),
        ),
      ),
      body: BlocConsumer<HomeViewBloc, AllDataState>(
        builder: (context, state) {
          if (state is HomeViewFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 174, 174, 174))),
                  TextButton(
                      onPressed: () {
                        print(user.location);
                        context.read<HomeViewBloc>().add(
                            FetchingStudioDataEvent(
                                params: AllParams(location: user.location)));
                      },
                      child: const Text('Retry',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            );
          }
          return [
            const HomeTab(),
            const ExploreTab(),
            const FavoritesTab(),
            ChatTab(
              socket: socket,
            ),
            const ProfileTab(),
          ][_currentIndex];
        },
        listener: (BuildContext context, AllDataState<dynamic> state) {
          if (state is HomeViewFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is HomeViewSuccess) {
            AppData.recomendedStudios =
                state.modelDatas['recomendedStudioModels']!;
            AppData.nearByStudios = state.modelDatas['nearbyStudios']!;
          }
        },
      ),
    );
  }

  changeTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildNavItem(int index, String title, String path) {
    final color = Theme.of(context).colorScheme;
    final iconColor =
        index == _currentIndex ? color.primary : ColorAssets.lightGray;

    return Expanded(
      flex: 1,
      child: Center(
        child: GestureDetector(
          onTap: () => changeTab(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                path,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: index == _currentIndex
                        ? color.primary
                        : ColorAssets.lightGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
