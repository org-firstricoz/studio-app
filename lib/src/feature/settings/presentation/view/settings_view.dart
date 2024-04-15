import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/views/onboarding/on_boarding_page.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/edit_profile_info.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/notification_settings_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/password_manager_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/widgets/delete_account_alert.dart';
import 'package:flutter_riverpod_base/src/feature/settings/widgets/theme_switch.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/utils/app_settings_handler.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/basic_sliver_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../res/colors.dart';

class SettingsView extends StatefulWidget {
  static String routePath = '/settings';

  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsDeleteSuccess) {
          context.go(OnBoardingPage.routePath);
          Hive.box('USER').clear();
        }
      },
      child: Scaffold(
        // backgroundColor: ColorAssets.white,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: BasicSliverAppbar(title: "Settings")),
            SliverList(
              delegate: SliverChildListDelegate([
                CustomListTile(
                  leadingIcon: Icon(
                    Icons.notifications_none_sharp,
                    color: colorScheme.primary,
                  ),
                  title: Text(
                    "Notification Settings",
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      // color: ColorAssets.blackFaded,
                    ),
                  ),
                  tailingIcon: Icon(Icons.chevron_right_rounded,
                      color: ColorAssets.primaryBlue),
                  onTap: () {
                    // AppSettingsHandler.openNotificationSettings(context);
                    context.push(NotificationSettingsView.routePath);
                  },
                ),
                const ThemeSwitchingWidget(),
                CustomListTile(
                  leadingIcon: SvgPicture.asset(
                    ImageAssets.trash2,
                    colorFilter: ColorFilter.mode(
                        ColorAssets.primaryBlue, BlendMode.srcIn),
                  ),
                  title: Text(
                    "Delete Account",
                  ),
                  onTap: () {
                    _showAccountDeleteAlert(context);
                  },
                  enableBottom: false,
                  tailingIcon: Icon(Icons.chevron_right_rounded,
                      color: ColorAssets.primaryBlue),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccountDeleteAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteAccountAlertModel();
        });
  }
}
