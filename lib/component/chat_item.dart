import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Message.dart';
import '../shared/shared.dart';

Widget chatItem(Message message, bool isUser, context) {
  return Row(
    mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(8),
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isUser ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: message.senderName,
                    style:
                    TextStyle( fontSize: 16, color: message.teacher! ? randomColor[1] :randomColor[2])),
                if(message.teacher!)
                  TextSpan(text: "(Teacher)",style: TextStyle(fontWeight: FontWeight.bold))
              ])),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 8),
              child: Text(message.text!, style: TextStyle(fontSize: 16, color: message.deleted! ? Colors.grey:Colors.black  )),
            ),
            Text(
              DateFormat('dd/MM/yyyy hh:mm')
                  .format(DateTime.parse(message.createAt!)),
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    ],
  );
}