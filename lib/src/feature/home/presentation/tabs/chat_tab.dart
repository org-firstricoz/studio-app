import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/shimmer_widget.dart';
import 'package:flutter_riverpod_base/src/core/models/chat.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/chat_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/bloc/home_view_bloc.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/sliverAppbarwithSearchbar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatTab extends StatefulWidget {
  const ChatTab({super.key, required this.socket});
  final IO.Socket socket;

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  bool _isSliverAppBarExpanded = false;
  @override
  void initState() {
    super.initState();
    if (AppData.chatData.isEmpty) {
      widget.socket.emit("chat_data");
    }
    widget.socket.on('chat_data', (data) {
      if (mounted)
        setState(() {
          AppData.chatData =
              data.map<ChatEntity>((e) => ChatEntity.fromMap(e)).toList();
        });
    });

    scrollController.addListener(() {
      setState(() {
        _isSliverAppBarExpanded =
            (scrollController.hasClients && scrollController.offset > 50);
      });
    });
  }

  String searchTerm = '';
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeViewBloc>().add(FetchingStudioDataEvent(
            params: AllParams(location: user.location)));
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
                    ShimmerWidget(
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShimmerWidget(
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShimmerWidget(
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShimmerWidget(
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }

          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppbarwithSearchBar(
                bgColor: color.primary,
                statusbarColor: color.secondary,
                context: context,
                controller: textEditingController,
                title: "Chat",
                isSliverAppBarExpanded: _isSliverAppBarExpanded,
                onChange: (val) {
                  searchTerm = val;
                  setState(() {});
                },
              ),
              _chatsBuilder(context)
            ],
          );
        },
      ),
    );
  }

  Widget _chatsBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final List<ChatEntity> chatData = AppData.chatData;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          final ChatEntity chat = chatData[index];
          final String name = chat.name.toString().toLowerCase();

          bool isSearchMatch =
              searchTerm.isEmpty || name.contains(searchTerm.toLowerCase());

          if (!isSearchMatch) {
            return const SizedBox.shrink();
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: ColorAssets.lightGray.withOpacity(0.5),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: MemoryImage(chat.photoUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // chat.unread != 0
                  //     ? const Icon(
                  //         Icons.circle,
                  //         color: Colors.green,
                  //       )
                  //     : const SizedBox.shrink(),
                  Text(
                    DateFormat(DateFormat.HOUR24_MINUTE).format(
                      chat.time,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorAssets.lightGray,
                    ),
                  ),
                ],
              ),
              onTap: () {
                context.push(ChatView.routePath, extra: {
                  'agentId': chat.agentId,
                  'socket': widget.socket,
                  'photoUrl': chat.photoUrl,
                  'name': chat.name,
                });
              },
            ),
          );
        },
        childCount: chatData.length,
      ),
    );
  }
}
