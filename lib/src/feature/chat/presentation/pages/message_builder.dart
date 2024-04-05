// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/feature/chat/presentation/message_input_box.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({
    Key? key,
    required this.msgdata,
    required this.agentModel,
    required this.searchString,
  }) : super(key: key);
  final List<ChatMessage> msgdata;
  final AgentModel agentModel;
  final String searchString;
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
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemBuilder: (context, index) => MessageBubble(
            searchString: widget.searchString,
            message: widget.msgdata[index].message,
            isMe: widget.msgdata[index].isMe,
          ),
          itemCount: widget.msgdata.length,
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: MessageInputBoxWidget(
              agentModel: widget.agentModel,
            ))
      ],
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
            child: Text(
              message,
            ).boldSubString(searchString, context, isMe)),
      ],
    );
  }
}
