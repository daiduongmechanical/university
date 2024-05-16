import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../component/info_tag.dart';
import '../data_type/KeyType.dart';
import '../layout/normal_layout.dart';
import '../model/DiscussRoomDto.dart';
import '../shared/shared.dart';
import 'discuss_page.dart';

class ListDiscussPage extends StatelessWidget {
  ListDiscussPage({super.key, required this.id});

  final int id;
  List<DiscussRoomDto> data = [];
  late SharedPreferences prefs;
  late final String jwt;

  Future<List<DiscussRoomDto>> getApiData() async {
    prefs = await SharedPreferences.getInstance();
    String useUrl = '$mainURL/api/discuss/list/$id';
    print(useUrl);
    String jwt = prefs.getString("jwt")!;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + jwt,
    };
    var url = Uri.parse(useUrl);

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      data.clear();
      final List<dynamic> responseData = json.decode(response.body);
      responseData.forEach((json) {
        data.add(DiscussRoomDto.fromJson(json));
      });

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return NormalLayout(
        headText: "List Discuss Room",
        child: Padding(
          padding: const EdgeInsets.only(top:15),
          child: FutureBuilder(
              future: getApiData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                    size: 70,
                    color: Colors.purple,
                  ));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InfoTag(
                        data: [
                          KeyValue(key: "Name", value: data[index].name!),
                          KeyValue(
                              key: "Expired",
                              value: DateFormat('dd/MM/yyyy hh:mm').format(
                                  DateTime.parse(data[index].expiredDate!))),
                          KeyValue(key: "Topic", value: data[index].topic!)
                        ],
                        icon: Icon(Icons.navigate_next),
                        page: DiscussPage(roomId: data[index].id!),
                      );
                    },
                  );
                }
              }),
        ));
  }
}
