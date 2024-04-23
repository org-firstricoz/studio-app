import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';

import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';

import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/custon_dash_separated_divider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TourRequestView extends StatefulWidget {
  static String routePath = '/tour-request';
  final DateTime date;
  const TourRequestView({
    super.key,
    required this.date,
  });

  @override
  State<TourRequestView> createState() => _TourRequestViewState();
}

class _TourRequestViewState extends State<TourRequestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      appBar: AppBar(
        title: const Text("Tour Request"),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
                params: AllParams(location: user.location)));
            context.go(HomeView.routePath);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: ColorAssets.primaryBlue,
                      child: Icon(
                        Icons.done_rounded,
                        size: 80,
                        color: ColorAssets.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Request Recieved!",
                      style: TextStyle(
                          fontSize: 22,
                          color: ColorAssets.blackFaded,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      "we’re Checking if the Studio can be seenon",
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorAssets.lightGray,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(widget.date),
                      style: const TextStyle(
                          fontSize: 14,
                          color: ColorAssets.blackFaded,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    CustomDashSeparatedDivider(
                      height: 2,
                      color: ColorAssets.lightGray.withOpacity(0.5),
                    ),
                    _buildAgentsContactTile(context)
                  ],
                ),
              ),
            ),
          ),
          // done button
          Container(
            height: 82,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
                color: ColorAssets.white,
                boxShadow: [
                  BoxShadow(color: ColorAssets.lightGray, blurRadius: 3)
                ],
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20))),
            child: Center(
              child: CustomTextButton(
                  text: "Done",
                  ontap: () {
                    context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
                        params: AllParams(location: user.location)));
                    context.go(HomeView.routePath);
                  }),
            ),
          ),

          // button
        ],
      ),
    );
  }

  _buildAgentsContactTile(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
          width: double.maxFinite,
        ),
        const Text(
          'Agent Will Take you on the tour!',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorAssets.lightGray),
        ),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          leading: CircleAvatar(
            backgroundColor: color.secondary,
            radius: 20,
            backgroundImage: NetworkImage(AppData.agentDetails.first.photoUrl),
          ),
          title: Text(
            AppData.agentDetails.first.name,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorAssets.blackFaded),
          ),
          subtitle: Text(
            AppData.agentDetails.first.status,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: ColorAssets.lightGray),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        )
      ],
    );
  }
}
