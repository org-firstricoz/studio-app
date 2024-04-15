import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/chat.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/chat_view.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/sliverAppbarwithSearchbar.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

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
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppbarwithSearchBar(
          statusbarColor: color.primary,
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
  }

  Widget _chatsBuilder(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final List<ChatDetails> chatData = AppData.chatData;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          final ChatDetails chat = chatData[index];
          final String name = chat.agentModel.name.toString().toLowerCase();

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
                backgroundImage: NetworkImage(chat.agentModel.photoUrl),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    chat.agentModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ColorAssets.blackFaded,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  chat.unread != 0
                      ? Icon(
                          Icons.circle,
                          color: Colors.green,
                        )
                      : SizedBox.shrink(),
                  Text(
                    DateFormat(DateFormat.HOUR24_MINUTE)
                        .format(DateTime.parse(chat.time,)),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorAssets.lightGray,
                    ),
                  ),
                ],
              ),
              onTap: () {
                context.push(ChatView.routePath,
                    extra: {'agent_model': chat.agentModel});
              },
            ),
          );
        },
        childCount: chatData.length,
      ),
    );
  }
}
