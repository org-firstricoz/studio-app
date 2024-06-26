import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/shimmer_widget.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/near_by_studios_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/recomended_studios_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/widgets/app_bar.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../res/colors.dart';
import '../../../../res/data.dart';
import '../../../../utils/widgets/item_card_view.dart';
import '../../../../utils/widgets/item_list_tile_view.dart';
import '../widgets/categories_horizontal_list_view.dart';
import '../widgets/custom_search_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  IO.Socket connect() {
    final socket = IO.io(AppRequestUrl.baseUrl, {
      'transports': ['websocket'],
      'autoConnect': true
    });
    socket.connect();
    socket.onConnect((data) => log('connected'));
    log(socket.connected.toString());
    return socket;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
              params: AllParams(location: user.location)));
          connect();
        },
        child: BlocBuilder<HomeViewBloc, AllDataState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return ShimmerEffect(
                baseColor: const Color.fromARGB(255, 215, 215, 215),
                highlightColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 20,
                          ),
                          ShimmerWidget(
                            height: 10,
                            width: 100,
                          )
                        ],
                      ),
                      ShimmerWidget(
                        height: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                            ShimmerWidget(
                              width: 40,
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ShimmerWidget(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ShimmerWidget(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              ItemCardView(
                                  studioModel: StudioModel.empty(),
                                  onClick: () {}),
                              SizedBox(
                                width: 10,
                              ),
                              ItemCardView(
                                  studioModel: StudioModel.empty(),
                                  onClick: () {})
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ShimmerWidget(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ShimmerWidget(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ItemListTileView(
                        studioModel: StudioModel.empty(),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ItemListTileView(
                        studioModel: StudioModel.empty(),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              );
            }

            return CustomScrollView(slivers: [
              const SliverAppBar(
                  leading: SizedBox.shrink(),
                  expandedHeight: kToolbarHeight + 80,
                  floating: false,
                  pinned: true,
                  scrolledUnderElevation: 0,
                  collapsedHeight: kToolbarHeight + 80,
                  flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      background: Column(
                        children: [
                          HomeViewAppBar(),
                          CustomSearchBar(),
                        ],
                      ))),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CategoriesHorizontalListView(),
                    _recomendationsListView(),
                    _nearbyListView(),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }

  _headerBuilder({required String title, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "See all",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorAssets.primaryBlue),
          ),
        )
      ],
    );
  }

  _recomendationsListView() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: _headerBuilder(
              title: "Recomended Studio",
              onTap: () {
                context.push(RecommendedStudiosView.routePath,
                    extra: AppData.recomendedStudios);
              }),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 254,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: AppData.recomendedStudios.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final data = AppData.recomendedStudios[index];
              return Container(
                padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 0, right: 10, top: 2, bottom: 2),
                child: ItemCardView(
                    studioModel: data,
                    onClick: () {
                      context
                          .push(BookingView.routePath, extra: {'id': data.id});
                    }),
              );
            },
          ),
        ),
      ],
    );
  }

  _nearbyListView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _headerBuilder(
              title: "Nearby Studios",
              onTap: () {
                context.push(NearbyStudiosView.routePath,
                    extra: AppData.nearByStudios);
              }),
          AppData.nearByStudios.isNotEmpty
              ? ListView.builder(
                  itemCount: AppData.nearByStudios.length,
                  // scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = AppData.nearByStudios[index];
                    return Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: ItemListTileView(
                          studioModel: data,
                          onTap: () {
                            context.push(BookingView.routePath,
                                extra: {'id': data.id});
                          }),
                    );
                  },
                )
              : const Center(
                  child: Text(
                      'No One is near you </3, So sorry !!! Checkout our Recomended Studios :>'),
                ),
        ],
      ),
    );
  }
}
