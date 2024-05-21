import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import '../../component/custom_select.dart';
import '../../data_type/select_time_data.dart';
import '../../layout/normal_layout.dart';
import '../../model/mark.dart';
import '../../shared/shared.dart';
import 'detail_mark_page.dart';


class MarkReportPage extends StatefulWidget {
  @override
  State<MarkReportPage> createState() => MarkReportPageState();
}

class MarkReportPageState extends State<MarkReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _semesterSelect = DateTime.now().month - 8 >= 0 ? 2 : 1;
  late int _yearSelect = DateTime.now().year;
  late List<Mark> listMark = [];

  Future<void> getApiCourse(
      {required int year, required int id, required int semester}) async {
    final apiUrl = "${mainURL}/mark?year=${year}&id=${id}&semester=${semester}";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        listMark.clear();
        responseData.forEach((courseJson) {
          listMark.add(Mark.fromJson(courseJson));
        });

        print(listMark.length);
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<SelectTimeDate> data = [
    SelectTimeDate(value: 1, key: 'Semester 1'),
    SelectTimeDate(value: 2, key: 'Semester 2')
  ];

  List<SelectTimeDate> listYear = [
    SelectTimeDate(value: 2023, key: '2023-2024'),
    SelectTimeDate(value: 2024, key: '2024-2025')
  ];

  @override
  Widget build(BuildContext context) {
    return NormalLayout(
      headText: 'Mark report',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSelect(
                        onChanged: (value) {
                          setState(() {
                            _semesterSelect = value!;
                          });
                          getApiCourse(
                              year: _yearSelect,
                              id: 1,
                              semester: _semesterSelect);
                        },
                        data: data,
                        text: 'Semester',
                      ),
                    ),
                    Expanded(
                        child: CustomSelect(
                      onChanged: (value) {
                        setState(() {
                          _yearSelect = value!;
                        });
                        getApiCourse(
                            year: _yearSelect,
                            id: 1,
                            semester: _semesterSelect);
                      },
                      data: listYear,
                      text: 'Year',
                    ))
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  child: ListView.builder(
                    itemCount: listMark.length,
                    itemBuilder: (context, index) {
                      Mark item = listMark[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: IntrinsicHeight(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                border: Border.all(color: Colors.black),
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Scaffold.of(context).closeEndDrawer();
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: DetailMarkPage(data: item,),
                                      ctx: context,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: Container(
                                          height: double.infinity, // Set height to maximum allowed
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: Colors.black),
                                            ),
                                          ),
                                          child: Center(child: Text(item.name ??"default")),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: Center(child: Text(item.averageMark.toString() ?? "pending")),
                                            ),
                                            Container(
                                              height: 40,
                                              child: Center(child: Text("Content 3")),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
