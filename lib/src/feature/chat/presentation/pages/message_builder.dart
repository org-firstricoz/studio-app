// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/message_input_box.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({
    Key? key,
    required this.msgdata,
    required this.agentId,
    required this.searchString,
    required this.socket,
  }) : super(key: key);
  final List<ChatMessage> msgdata;
  final String agentId;
  final String searchString;
  final Socket socket;
  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    widget.socket.on('message', (data) {
      log(data.toString());
      final msgData = jsonDecode(jsonEncode(data));

      setState(() {
        widget.msgdata.add(ChatMessage.fromMap(msgData));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) => MessageBubble(
                  searchString: widget.searchString,
                  message: widget.msgdata[index].message,
                  isMe: widget.msgdata[index].isMe,
                ),
                itemCount: widget.msgdata.length,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: MessageInputBoxWidget(
                  scrollController: scrollController,
                  socket: widget.socket,
                  agentId: widget.agentId,
                ))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String searchString;

  const MessageBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.searchString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 283,
          ),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            // color: color.surfaceVariant,
            color: isMe ? color.primary : color.surface,
            border: Border.all(
              color: isMe
                  ? Colors.transparent
                  : ColorAssets.blackFaded.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.only(
              topRight: isMe ? Radius.zero : const Radius.circular(15),
              topLeft: isMe ? const Radius.circular(15) : Radius.zero,
              bottomLeft: const Radius.circular(15),
              bottomRight: const Radius.circular(15),
            ),
          ),
          child: RichText(
            text: TextSpan(
                text: message, style: TextStyle(color: ColorAssets.black)),
          ),
        )
      ],
    );
  }
}
