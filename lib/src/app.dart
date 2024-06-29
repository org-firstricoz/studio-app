import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/main.dart';
import 'package:flutter_riverpod_base/services_imports.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/bloc/help_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/save_local_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/bloc/search_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/review_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/settings/provider/theme_provider.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/router.dart';
import 'package:upgrader/upgrader.dart';
import '../color_schemes.g.dart';

final GlobalKey<State<StatefulWidget>> dialogKey =
    GlobalKey<State<StatefulWidget>>();

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<SaveLocalBloc>()),
        BlocProvider(create: (context) => serviceLocator<HomeViewBloc>()),
        BlocProvider(create: (context) => serviceLocator<BookingBloc>()),
        BlocProvider(create: (context) => serviceLocator<SearchBloc>()),
        BlocProvider(create: (context) => serviceLocator<ChatBloc>()),
        BlocProvider(create: (context) => serviceLocator<SettingsBloc>()),
        BlocProvider(create: (context) => serviceLocator<HelpBloc>()),
        BlocProvider(create: (context) => serviceLocator<ReviewBloc>())
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          context
              .read<HomeViewBloc>()
              .add(SavingFavouritesEvent(params: AppData.favouriteModel));
          // print(didPop);
        },
        child: MaterialApp.router(
            // theme: Themes.lightTheme(context),
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            // darkTheme: Themes.darkTheme(context),
            themeMode: themeModeState,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            builder: (context, child) => StreamBuilder(
                  stream: upgrader.stateStream,
                  builder: (context, snapshot) => UpgradeAlert(
                    dialogKey: dialogKey,
                    showReleaseNotes: true,
                    upgrader: upgrader,
                    navigatorKey: router.routerDelegate.navigatorKey,
                    showIgnore: false,
                    showLater: false,
                    shouldPopScope: () => false,
                    child: child,
                  ),
                )),
      ),
    );
  }
}
