import 'package:flutter/cupertino.dart';

import '../model/Message.dart';
import 'chat_item.dart';

class ListChat extends StatelessWidget {
  List<Message> messages;
  int studentId;
  final ScrollController scrollController;

  ListChat({
    super.key,
    required this.messages,
    required this.studentId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return chatItem(messages[index],
              messages[index].senderId == studentId ? true : false, context);
        },
      ),
    );
  }
}