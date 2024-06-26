import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_riverpod_base/src/commons/animation/glass_morphic_effect.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/sharing_utils.dart';

part '../widgets/mute_notifcations_popup.dart';
part '../widgets/profile_qr_popup.dart';
part '../widgets/shared_media_viewer_bottom_sheet.dart';

class UserChatProfileView extends StatefulWidget {
  static String routePath = '/user-chat-profile';
  final String agentId;
  const UserChatProfileView({Key? key, required this.agentId})
      : super(key: key);

  @override
  State<UserChatProfileView> createState() => _UserChatProfileViewState();
}

class _UserChatProfileViewState extends State<UserChatProfileView> {
  @override
  void initState() {
    super.initState();
    context
        .read<ChatBloc>()
        .add(GetAgentDetailsEvent(agentID: widget.agentId));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: SimpleAppBar(
          leadingCallback: () {
            context.pushReplacement(HomeView.routePath);
          },
          title: 'Profile',
          centerTitle: true,
          actions: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is AgentDetailsSuccessState) {
                  return GestureDetector(
                    onTap: () {
                      SharingUtils.shareUserProfileINFO(
                          context: context,
                          text: state.agentDetails.name,
                          subject: state.agentDetails.number);
                    },
                    child: CircleAvatar(
                      backgroundColor: colorScheme.secondary,
                      child: const Icon(Icons.share_rounded),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ChatFailureState) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AgentDetailsSuccessState) {
              return
                  //  PreferredSize(
                  //   preferredSize: Size.fromHeight(kToolbarHeight),
                  //   child: StudioAppBar(title: 'Profile', actions: [
                  //     IconButton(
                  //       onPressed: () {
                  //         SharingUtils.shareUserProfileINFO(
                  //             context: context,
                  //             text: "Pavan kumar",
                  //             subject: "+91 33543 545 444");
                  //       },
                  //       icon: Icon(Icons.share_rounded),
                  //     ),
                  //     SizedBox(width: 10),
                  //   ]),
                  // ),

                  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            state.agentDetails.photoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox();
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GlassMophicEffect(
                              child: CustomListTile(
                                onTap: () {},
                                title: Text(
                                  state.agentDetails.name,
                                  style: textTheme.titleLarge,
                                ),
                                subtitle: Text(
                                  state.agentDetails.number,
                                  style: textTheme.titleMedium,
                                ),
                                tailingIcon: IconButton(
                                  icon: Icon(
                                    Icons.qr_code,
                                    color: colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    _showQrCode(state);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.agentDetails.description,
                          style: textTheme.titleLarge!.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Media',
                                    style: textTheme.bodyLarge!.copyWith(),
                                  ),
                                  Text(
                                    'View All',
                                    style: textTheme.bodyLarge!
                                        .copyWith(color: colorScheme.primary),
                                  ).onTap(() {
                                    _viewAllSharedMedia(
                                        context, state.agentDetails.media);
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.agentDetails.media
                                    .length, // Adjust itemCount accordingly
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 10 : 10,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.memory(
                                      state.agentDetails.media[index],
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        log('error');
                                        return SizedBox();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).addSpacingBetweenElements(10),
                      ),
                    ),
                    // Card(
                    //   child: CustomListTile(
                    //     leadingIcon: const Icon(Icons.backup_rounded),
                    //     onTap: () {},
                    //     title: const Text('Backup chat'),
                    //   ),
                    // ),
                    // Card(
                    //   child: Column(
                    //     children: [
                    //       CustomListTile(
                    //         leadingIcon: Icon(
                    //           Icons.block_rounded,
                    //           color: colorScheme.error,
                    //         ),
                    //         error: true,
                    //         title: const Text('Block Pavan Kumar'),
                    //         onTap: () {},
                    //       ),
                    //       CustomListTile(
                    //         leadingIcon: Icon(
                    //           Icons.thumb_down,
                    //           color: colorScheme.error,
                    //         ),
                    //         error: true,
                    //         title: const Text('Report Pavan Kumar'),
                    //         onTap: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ).addSpacingBetweenElements(5),
              );
            } else {
              return const Scaffold();
            }
          },
        ));
  }

  void _showQrCode(state) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => ProfileQRPopup(
        qrData: state.agentDetails.qrData,
      ),
    );
  }

  void _viewAllSharedMedia(BuildContext context, List<Uint8List> media) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SharedChatMediaBottomSheet(media: media));
  }
}
