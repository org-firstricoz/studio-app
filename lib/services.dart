
part of 'services_imports.dart';

final GetIt serviceLocator = GetIt.instance;
void serviceInjector() {
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());
  registerDataSource(serviceLocator);
  registerRepository(serviceLocator);
  registerUsecase(serviceLocator);
  registerBlocs(serviceLocator);
}

void registerDataSource(GetIt serviceLocator) {
  // REGISTER DATASOURCE
  serviceLocator.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<RemoteDataSource>(
      RemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<ScheduleRemoteDataSource>(
      ScheduleRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<ChatRemoteDataSource>(
      ChatRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<HomeViewRemoteDataSource>(
      HomeViewRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<FilterDataSource>(
      FilterDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<SearchViewRemoteDataSource>(
      SearchViewRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerSingleton<SettingsDataSource>(
      SettingsDataSourceImpl(client: serviceLocator()));
}

void registerRepository(GetIt serviceLocator) {
  // REPOSITORY
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<BookingRepository>(
      () => BookingRepositoryImpl(remoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(chatRemoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<HomeViewRepository>(
      () => HomeViewRepositoryImpl(dataSource: serviceLocator()));
  serviceLocator.registerFactory<FilterRepository>(
      () => FilterRepositoryImpl(filterDataSource: serviceLocator()));
  serviceLocator.registerFactory<SearchViewRepository>(
      () => SearchViewRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory<SettingsRepository>(
      () => SettingsRepositoryImpl(dataSource: serviceLocator()));
  serviceLocator.registerFactory<ScheduleRepository>(
      () => ScheduleRepositoryImpl(scheduleRemoteDataSource: serviceLocator()));
}

void registerUsecase(GetIt serviceLocator) {
  // AUTHENTICATION
  serviceLocator
      .registerFactory(() => SendOtp(authRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => LoginWithOtp(authRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => ManualLocation(authRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetLocation(authRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => LoginUserWithEmailAndPassword(authRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => CreateUserWithEmailAndPassword(authRepository: serviceLocator()));

// LOCALDATA
  serviceLocator.registerFactory(
      () => SaveFavouritesLocally(homeViewRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => SaveFavourites(homeViewRepository: serviceLocator()));

// HOMEVIEW
  serviceLocator.registerFactory(
      () => GetHomeViewDetails(homeViewRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => SendingData(scheduleRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => RequestingSchedule(scheduleRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => GetAboutSection(bookingRepository: serviceLocator()));

  // SEARCH/FILTER
  serviceLocator
      .registerFactory(() => FilterUseCase(filterRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => SearchView(searchViewRepository: serviceLocator()));

  // CHATS
  serviceLocator
      .registerFactory(() => GetAgentDetails(chatRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => SendMessage(chatRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => ChatService(chatRepository: serviceLocator()));

  // SETTINGS
  serviceLocator.registerFactory(
      () => DeleteAccount(settingsRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateData(settingsRepository: serviceLocator()));

  //HELP
  serviceLocator.registerFactory(
      () => HelpCentre(helpCentreRepository: serviceLocator()));

  // REVIEW
  serviceLocator.registerFactory(
      () => DeleteReviewSction(bookingRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => AddReviewSection(bookingRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => EditReviewSction(bookingRepository: serviceLocator()));
}

void registerBlocs(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton(() => AuthBloc(
      manualLocation: serviceLocator(),
      loginWithOtp: serviceLocator(),
      sendOtp: serviceLocator(),
      createUserWithEmailAndPassword: serviceLocator(),
      loginUserWithEmailAndPassword: serviceLocator(),
      getLocation: serviceLocator()));

  serviceLocator.registerLazySingleton(
      () => SaveLocalBloc(saveFavouritesLocally: serviceLocator()));

  serviceLocator.registerLazySingleton(() => HomeViewBloc(
      getHomeViewDetails: serviceLocator(), saveFavourites: serviceLocator()));

  serviceLocator.registerLazySingleton(() => BookingBloc(
      getAboutSection: serviceLocator(),
      requestingSchedule: serviceLocator(),
      sendingData: serviceLocator()));

  serviceLocator.registerLazySingleton(() => SearchBloc(
        searchView: serviceLocator(),
        filterUseCase: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ChatBloc(
        chatService: serviceLocator(),
        sendMessage: serviceLocator(),
        getAgentdetails: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => SettingsBloc(
      updateData: serviceLocator(), deleteAccount: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => HelpBloc(helpCentre: serviceLocator()));
  serviceLocator.registerLazySingleton(() => ReviewBloc(
        editReviewSction: serviceLocator(),
        deleteReviewSction: serviceLocator(),
        addReviewSection: serviceLocator(),
      ));
}
