import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../data_type/ReciveMessage.dart';
import '../data_type/SendMessage.dart';
import '../layout/normal_layout.dart';
import '../model/Message.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../shared/shared.dart';

class DiscussPage extends StatefulWidget {
   DiscussPage({super.key, required this.roomId});

  final int roomId;
  @override
  State<DiscussPage> createState() => _DiscussState();
}

class _DiscussState extends State<DiscussPage> {
  late StompClient client;
  late final SharedPreferences prefs;
  late final String jwt;
  final ScrollController _scrollController = ScrollController();
  final messageController = TextEditingController();

  late  int id=0;

  List<Message> messages = [];

  void onConnectCallback(StompFrame connectFrame) async {
    print("connected");
    client.subscribe(
        destination: '/topic/public/2',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + jwt,
        },
        callback: (frame) {
          var jsonData = json.decode(frame.body!);
          ReciveMessage data = ReciveMessage.fromJson(jsonData);
          if(data.type=="CHAT"){
            setState(() {
              messages.add(Message(
                  id: data.id,
                  text: data.text,
                  createAt: data.createAt,
                  senderName: data.senderName,
                  senderId: data.senderId,
                  teacher: true));
            });
            scrollToBottom();
          }

          if(data.type=="DELETE"){

            messages.forEach((e) {
             if ( e.id== data.id){
                e.text="This message is recalled";
                e.deleted=true;

              }
             setState(() {

             });
             scrollToBottom();
            });
          }

          if(data.type=="OVER"){
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              body: Center(child: Text(
                "This discus is expired, can't sent new message",
                style: TextStyle(fontStyle: FontStyle.normal),
              ),),
              title: 'This is Ignored',
              desc:   'This is also Ignored',
              btnOkOnPress: () {},
            )..show();
          }

        });

  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // At the bottom of ListView
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void sendMessage()  {
    Map<String, String> headers = {"Content-type": "application/json"};

    SendMessage mess = SendMessage(
        sender: 'new sender',
        content: messageController.text,
        id: id,
        roomId: 2,
        type: 'CHAT');
    client.send(
        destination: '/app/chat.sendMessage/2',
        body: jsonEncode(mess),
        headers: headers);

    scrollToBottom();
  }

  Future getPageData() async {
    prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString("jwt")!;
    id = prefs.getInt("id")!;
    client.activate();
    String useUrl = '$mainURL/api/discuss/room/2';
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.get(Uri.parse(useUrl), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        responseData.forEach((json) {
          messages.add(Message.fromJson(json));
        });
      });
    } else {
      print("hav eror");
    }
  }

  @override
  void initState() {
    super.initState();
    getPageData();

    client = StompClient(
      config: StompConfig(
        url: wsUrl,
        onConnect: onConnectCallback,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => client.deactivate(),
        stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
        webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
      ),
    );


    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    client.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    scrollToBottom();
    return NormalLayout(
        headText: "Discuss",
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: 50,
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Topic :",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextSpan(text: "Ai là người đầu tiên ăn thịt chó ")
                ])),
              ),
            ),
            Flexible(
                child: ListChat(
              messages: messages,
              studentId: id,
              scrollController: _scrollController,
            )),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(3, 0),
                    ),
                  ],
                ),
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border:  Border.all(width: 2.0, color: const Color(0xFFFFFFFF))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(

                          hintText: "Enter your message",
                        ),
                      )),
                      IconButton(
                          onPressed: () {
                            if(messageController.text.trim().isNotEmpty){
                              sendMessage();
                            }

                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ))
          ],
        ));
  }
}

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
