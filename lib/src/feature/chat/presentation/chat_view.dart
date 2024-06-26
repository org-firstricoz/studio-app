import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/pages/message_builder.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/pages/user_chat_profile.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatView extends StatefulWidget {
  static String routePath = '/chat-view';
  final String agentId;
  final Socket socket;
  final String name;
  final Uint8List photoUrl;
  const ChatView(
      {super.key,
      required this.agentId,
      required this.socket,
      required this.name,
      required this.photoUrl});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    widget.socket.emit("chat", user.uuid);
    widget.socket.on("chat", (chats) {
      log(chats.toString(), name: "CHATS");
      if (mounted)
        setState(() {
          AppData.chatMessages =
              chats.map<ChatMessage>((e) => ChatMessage.fromMap(e)).toList();
        });
    });
    // context.read<ChatBloc>().add(GetChatDataEvent(
    //     chatParams: ChatParams(agentId: widget.agentId, userId: user.uuid)));
  }

  bool showsSearchBar = false;
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: SimpleAppBar(
        bgColor: colorScheme.primary,
        title: "title",
        titleWidget: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
              radius: 20, backgroundImage: MemoryImage(widget.photoUrl)),
          title: Text(
            widget.name,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
                fontSize: 14),
          ),
          onTap: () {
            context.push(UserChatProfileView.routePath,
                extra: {'agentId': widget.agentId});
          },
        ),
        bottom: showsSearchBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                  child: FormTextField(
                    onChanged: (val) {
                      searchString = val;
                      setState(() {});
                    },
                    suffixIcon: IconButton(
                        onPressed: () {
                          toggleSearchBar();
                        },
                        icon: const Icon(Icons.clear)),
                    // labelText: 'Email',
                    hintText: "Search..",
                  ),
                ),
              )
            : null,
        actions: [
          ChatPopUpMenuBuilder(
              toggleSearchBar: toggleSearchBar, id: widget.agentId),
        ],
      ),
      backgroundColor: colorScheme.primary,
      body: Container(
          decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14))),
          child: ChatComponent(
            socket: widget.socket,
            msgdata: AppData.chatMessages,
            searchString: searchString,
            agentId: widget.agentId,
          )),
    );
  }

  void toggleSearchBar() {
    setState(() {
      searchString = '';
      showsSearchBar = !showsSearchBar;
    });
  }
}

class ChatPopUpMenuBuilder extends StatefulWidget {
  const ChatPopUpMenuBuilder(
      {Key? key, required this.toggleSearchBar, required this.id})
      : super(key: key);
  final String id;
  final VoidCallback toggleSearchBar;
  @override
  State<ChatPopUpMenuBuilder> createState() => _ChatPopUpMenuBuilderState();
}

class _ChatPopUpMenuBuilderState extends State<ChatPopUpMenuBuilder> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<SampleItem>(
      onSelected: (SampleItem item) {
        if (SampleItem.viewProfile == item) {
          context
              .read<ChatBloc>()
              .add(GetAgentDetailsEvent(agentID: widget.id));
        }
      },
      color: colorScheme.surface,
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) {
        TextTheme textTheme = Theme.of(context).textTheme;
        ColorScheme colorScheme = Theme.of(context).colorScheme;
        return <PopupMenuEntry<SampleItem>>[
          PopupMenuItem<SampleItem>(
            value: SampleItem.search,
            onTap: () => widget.toggleSearchBar(),
            child: Text(
              'Search',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ),
          PopupMenuItem<SampleItem>(
            value: SampleItem.viewProfile,
            child: Text(
              'View Profile',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          PopupMenuItem<SampleItem>(
            value: SampleItem.muteNotifications,
            onTap: () => _toggleMuteMode(),
            child: Text(
              muteMode ? 'Unmute Notifications' : 'Mute Notificatios',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ];
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          child: CircleAvatar(
            backgroundColor: colorScheme.secondary,
            child: const Icon(
              Icons.more_vert,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  bool muteMode = false;

  void _toggleMuteMode() {
    muteMode = !muteMode;
    setState(() {});
  }
}

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  call,
  viewProfile,
  search,
  muteNotifications,
}
