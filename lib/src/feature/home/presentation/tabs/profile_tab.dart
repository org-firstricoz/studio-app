import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/onboarding/on_boarding_page.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/help_center_view.dart';
import 'package:flutter_riverpod_base/src/commons/views/privacy-policy/privacy_policicy.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/edit_profile_info.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/language_view.dart';
import 'package:flutter_riverpod_base/src/feature/settings/presentation/view/settings_view.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/basic_sliver_appbar.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../res/colors.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
            params: AllParams(location: user.location)));
      },
      child: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(

        const  SliverAppBar(
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            // profile
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              width: double.maxFinite,
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(user.photoUrl)),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 10),
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorAssets.blackFaded),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorAssets.lightGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            //   child: GestureDetector(
            //     onTap: () {
            //       // edit option

            //     },
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Icon(
            //           Icons.edit,
            //           size: 15,
            //           color: ColorAssets.primaryBlue,
            //         ),
            //         SizedBox(width: 3.51),
            //         Text(
            //           "EDIT",
            //           style: TextStyle(
            //               fontSize: 16,
            //               fontWeight: FontWeight.w600,
            //               color: ColorAssets.primaryBlue),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // options
            CustomListTile(
                leadingIcon: SvgPicture.asset(ImageAssets.user1),
                title: const Text(
                  "Your Profile",
                ),
                tailingIcon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorAssets.primaryBlue,
                ),
                onTap: () {
                  context.push(EditProfileInfoView.routePath);
                }),
            CustomListTile(
                leadingIcon: SvgPicture.asset(ImageAssets.settings),
                title: const Text(
                  "Settings",
                ),
                tailingIcon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorAssets.primaryBlue,
                ),
                onTap: () {
                  context.push(SettingsView.routePath);
                }),
            // CustomListTile(
            //     leadingIcon: SvgPicture.asset(ImageAssets.settings),
            //     title: const Text(
            //       "App Language",
            //     ),
            //     tailingIcon: const Icon(
            //       Icons.arrow_forward_ios_rounded,
            //       color: ColorAssets.primaryBlue,
            //     ),
            //     onTap: () {
            //       context.push(LanguageSelectionView.routePath);
            //     }),
            CustomListTile(
                leadingIcon: SvgPicture.asset(ImageAssets.lock),
                title: const Text(
                  "Privacy Policy",
                ),
                tailingIcon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorAssets.primaryBlue,
                ),
                onTap: () {
                  context.push(PrivacyPolicyView.routePath);
                }),
            CustomListTile(
                leadingIcon: SvgPicture.asset(ImageAssets.helpcircle),
                title: const Text(
                  "Help Center",
                ),
                tailingIcon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorAssets.primaryBlue,
                ),
                onTap: () {
                  context.push(HelpCenterView.routePath);
                }),
            CustomListTile(
                leadingIcon: const Icon(
                  Icons.logout,
                  color: ColorAssets.redAccent,
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorAssets.redAccent),
                ),
                onTap: () async {
                  context.go(OnBoardingPage.routePath);
                },
                enableBottom: false),
          ]))
        ],
      ),
    );
  }
}

// class SliverHomeHeader extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return AppBar(
//       // backgroundColor: Colors.white,
//       title: Text(
//         "Profile",
//         style: textTheme.titleLarge!.copyWith(
//           fontWeight: FontWeight.w600,
//           fontSize: 18,
//         ),
//       ),
//       centerTitle: true,
//       leading: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: GestureDetector(
//           onTap: () {
//             context.pop();
//           },
//           child: CircleAvatar(
//             // radius: 30,
//             backgroundColor: ColorAssets.lightGray.withOpacity(0.1),
//             child: Icon(
//               Icons.arrow_back,
//               color: ColorAssets.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 60;

//   @override
//   double get minExtent => 60;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
