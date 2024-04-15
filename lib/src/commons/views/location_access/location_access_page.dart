// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod_base/src/commons/views/location_access/widgets/manual_location_access_sheet.dart.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/complete_profile_info.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';

class LocationAccessPage extends StatelessWidget {
  static String routePath = '/location-access';

  const LocationAccessPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: color.surface,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LocationFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is LocationSuccess) {
                  userDetails.addAll({'location': state.city});
                  newUser
                      ? context.go(CompleteYourProfileInfoView.routePath)
                      : context.push(HomeView.routePath);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Fetching Your Location'),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(
                            color: color.secondary, shape: BoxShape.circle),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 80,
                          color: color.primary,
                        ),
                      ),
                      const Text(
                        "What is Your Location?",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "We need to know your location in order to suggest nearby  services.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: color.tertiary),
                      ),
                      CustomTextButton(
                          text: "Allow Location Access",
                          ontap: () async {
                            context
                                .read<AuthBloc>()
                                .add(FetchUserLocation(params: NoParams()));
                          }),
                      Text(
                        "Enter Location Manually",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: color.primary,
                        ),
                      ).onTap(() {
                        showLoactionAccessingBottomModelSheet(context);
                      }),
                    ],
                  ).addSpacingBetweenElements(15);
                }
                // return SizedBox
              },
            )));
  }
}
