import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/main.dart';
import 'package:flutter_riverpod_base/src/commons/views/filters/filter_view.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/help_center_view.dart';
import 'package:flutter_riverpod_base/src/commons/views/location_access/location_access_page.dart';
import 'package:flutter_riverpod_base/src/commons/views/notification/notification_view.dart';
import 'package:flutter_riverpod_base/src/commons/views/onboarding/on_boarding_page.dart';
import 'package:flutter_riverpod_base/src/commons/views/otp/login_otp.dart';
import 'package:flutter_riverpod_base/src/commons/views/privacy-policy/privacy_policicy.dart';
import 'package:flutter_riverpod_base/src/commons/views/splash.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/payment_gateway.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/chat_view.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/pages/user_chat_profile.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/complete_profile_info.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/edit_profile_info.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/pages/search_results_view.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/presentation/pages/studio_search_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/language_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/notification_settings_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/password_manager_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/settings_view.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../feature/booking/presentation/views/book_tour_view.dart';
import '../feature/booking/presentation/views/tour_request_view.dart';
import '../feature/home/presentation/near_by_studios_view.dart';
import '../feature/home/presentation/recomended_studios_view.dart';

final GoRouter router = GoRouter(
  initialLocation:
      //  LoginOtp.routePath,
      _cachedUser(),
  routes: [
    // name123
    // GoRoute(
    //   path: PaymentGateway.routePath,
    //   builder: (context, state) {
    //     // final extra = state.extra as Map;
    //     return PaymentGateway(
    //       amount: 300,
    //     );
    //   },
    // ),
    GoRoute(
      path: LoginOtp.routePath,
      builder: (context, state) {
        return const LoginOtp();
      },
    ),
    GoRoute(
      path: PasswordManagerView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const PasswordManagerView();
      },
    ),
    GoRoute(
      path: SearchResultsView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extras = state.extra as Map<String, dynamic>;
        return SearchResultsView(
          searchTerm: extras['query'],
        );
      },
    ),
    GoRoute(
      path: NotificationSettingsView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return NotificationSettingsView();
      },
    ),
    GoRoute(
      path: LanguageSelectionView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return LanguageSelectionView();
      },
    ),
    GoRoute(
      path: UserChatProfileView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;

        return UserChatProfileView(
          agentModel: extra['agent_model'],
        );
      },
    ),
    GoRoute(
      path: NotificationView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return NotificationView();
      },
    ),
    GoRoute(
      path: FilterView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const FilterView();
      },
    ),
    GoRoute(
      path: TourRequestView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        return TourRequestView(
          date: extra['date'],
        );
      },
    ),
    GoRoute(
      path: BookingTourView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extras = state.extra as Map;
        return BookingTourView(
          studioDetails: extras['studio_details'],
          time: extras['time'],
          date: extras['date'],
        );
      },
    ),
    GoRoute(
      path: BookingView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extras = state.extra as Map<String, dynamic>;

        return BookingView(
          id: extras['id'],
        );
      },
    ),
    GoRoute(
      path: ChatView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        final AgentModel agentModel = extra['agent_model'];
        return ChatView(
          agentModel: agentModel ?? AgentModel.empty(),
        );
      },
    ),
    GoRoute(
      path: PrivacyPolicyView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const PrivacyPolicyView();
      },
    ),
    GoRoute(
      path: StudioSearchView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const StudioSearchView();
      },
    ),
    GoRoute(
      path: HelpCenterView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpCenterView();
      },
    ),
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: OnBoardingPage.routePath,
      builder: (context, state) {
        return const OnBoardingPage();
      },
    ),
    // GoRoute(
    //   path: LoginPage.routePath,
    //   builder: (context, state) {
    //     return const LoginPage();
    //   },
    // ),
    // GoRoute(
    //   path: SignUpPage.routePath,
    //   builder: (context, state) {
    //     return const SignUpPage();
    //   },
    // ),
    GoRoute(
      path: CompleteYourProfileInfoView.routePath,
      builder: (context, state) {
        return const CompleteYourProfileInfoView();
      },
    ),
    GoRoute(
      path: EditProfileInfoView.routePath,
      builder: (context, state) {
        return const EditProfileInfoView();
      },
    ),
    GoRoute(
      path: LocationAccessPage.routePath,
      builder: (context, state) {
        return const LocationAccessPage();
      },
    ),
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: SettingsView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return SettingsView();
      },
    ),
    GoRoute(
      path: NearbyStudiosView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return NearbyStudiosView(studios: state.extra as List<StudioModel>);
      },
    ),
    GoRoute(
      path: RecommendedStudiosView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return RecommendedStudiosView(
            studios: state.extra as List<StudioModel>);
      },
    ),
  ],
);

_cachedUser() {
  final box = Hive.box('USER');
  if (box.isNotEmpty) {
    final token = box.get('token');
    final bool val = JwtDecoder.isExpired(token);
    if (val) {
      return SplashView.routePath;
    } else {
      final userDetails = JwtDecoder.decode(token);
      user = User.fromMap(userDetails);
      return HomeView.routePath;
    }
  } else {
    return SplashView.routePath;
  }
}
