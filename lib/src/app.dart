import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_base/src/feature/auth/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/datasource/schedule_remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/repository/booking_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/repository/schedule_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/get_about_section.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/requesting_schedule.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/chat/data/datasource/chat_remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/chat/data/repository/chat_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/chat/domain/repository/chat_repository.dart';
import 'package:flutter_riverpod_base/src/feature/chat/domain/usecase/chat_service.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/home/data/repository/home_view_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/usecase/get_home_view_details.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/datasource/filter_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/repository/filter_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/repository/search_view_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/usecase/filter_use_case.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/usecase/search_view.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/bloc/search_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/settings/data/datasource/update_data_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/settings/data/repository/update_data_repository_impl.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/update_data_repository.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/usecase/update_data.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/settings/provider/theme_provider.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/router.dart';
import 'package:http/http.dart' as http;
import '../color_schemes.g.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              sendOtp: SendOtp(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client()))),
              loginWithOtp: LoginWithOtp(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client()))),
              manualLocation: ManualLocation(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client()))),
              getLocation: GetLocation(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client()))),
              loginUserWithEmailAndPassword: LoginUserWithEmailAndPassword(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client()))),
              createUserWithEmailAndPassword: CreateUserWithEmailAndPassword(
                  authRepository: AuthRepositoryImpl(
                      authRemoteDataSource:
                          AuthRemoteDataSourceImpl(client: http.Client())))),
        ),
        BlocProvider(
            create: (context) => HomeViewBloc(
                  saveFavourites: SaveFavourites(
                      homeViewRepository: HomeViewRepositoryImpl(
                          dataSource: HomeViewRemoteDataSourceImpl())),
                  getHomeViewDetails: GetHomeViewDetails(
                      homeViewRepository: HomeViewRepositoryImpl(
                          dataSource: HomeViewRemoteDataSourceImpl())),
                )),
        BlocProvider(
            create: (context) => BookingBloc(
                sendingData: SendingData(
                    scheduleRepository: ScheduleRepositoryImpl(
                        scheduleRemoteDataSource: ScheduleRemoteDataSourceImpl(
                            client: http.Client()))),
                requestingSchedule: RequestingSchedule(
                    scheduleRepository: ScheduleRepositoryImpl(
                        scheduleRemoteDataSource: ScheduleRemoteDataSourceImpl(
                            client: http.Client()))),
                getAboutSection: GetAboutSection(
                    bookingRepository: BookingRepositoryImpl(
                        remoteDataSource:
                            RemoteDataSourceImpl(client: http.Client()))),
                addreviewSection: AddReviewSection(
                    bookingRepository: BookingRepositoryImpl(
                        remoteDataSource:
                            RemoteDataSourceImpl(client: http.Client()))))),
        BlocProvider(
          create: (context) => SearchBloc(
              filterUseCase: FilterUseCase(
                  filterRepository: FilterRepositoryImpl(
                      filterDataSource:
                          FilterDataSourceImpl(client: http.Client()))),
              searchView: SearchView(
                  searchViewRepository: SearchViewRepositoryImpl(
                      SearchViewRemoteDataSourceImpl(client: http.Client())))),
        ),
        BlocProvider(
            create: (context) => ChatBloc(
                getAgentdetails: GetAgentDetails(
                    chatRepository: ChatRepositoryImpl(
                        chatRemoteDataSource:
                            ChatRemoteDataSourceImpl(client: http.Client()))),
                sendMessage: SendMessage(
                    chatRepository: ChatRepositoryImpl(
                        chatRemoteDataSource:
                            ChatRemoteDataSourceImpl(client: http.Client()))),
                chatService: ChatService(
                    chatRepository: ChatRepositoryImpl(
                        chatRemoteDataSource:
                            ChatRemoteDataSourceImpl(client: http.Client()))))),
        BlocProvider(
            create: (context) => SettingsBloc(
                updateData: UpdateData(
                    updateDataRepository: UpdateDataRepositoryImpl(
                        dataSource:
                            UpdateDataDataSourceImpl(client: http.Client()))))),
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          context
              .read<HomeViewBloc>()
              .add(SavingFavouritesEvent(params: AppData.favouriteModel));
          print(didPop);
        },
        child: MaterialApp.router(
          // theme: Themes.lightTheme(context),
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          // darkTheme: Themes.darkTheme(context),
          themeMode: themeModeState,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
