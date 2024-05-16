import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../data_type/drawer_data.dart';
import '../page/homepage.dart';
import '../page/list_class_attend_page.dart';
import '../page/mark_report_page.dart';
import '../page/RegisterSubject/subject_register_page.dart';
import '../page/test_page.dart';
import '../page/time_table_page.dart';
import '../shared/shared.dart';

class CustomDrawer extends StatelessWidget {
  static List<DrawerData> drawerItems = [
    DrawerData(name: 'Home', icon: const Icon(Icons.home), page: HomePage()),
    DrawerData(
        name: 'Settings', icon: const Icon(Icons.settings), page: TestPage()),
    DrawerData(
        name: 'Resgister subject',
        icon: const Icon(Icons.home),
        page: RegisterPage()),
    DrawerData(
        name: "Discuss",
        icon: Icon(Icons.chat_bubble),
        page: ListClassAttend()),
    DrawerData(
        name: 'Time table',
        icon: const Icon(Icons.calendar_month),
        page: TimeTablePage()),
    DrawerData(
        name: 'Mark report',
        icon: const Icon(Icons.view_comfortable),
        page: MarkReportPage()),
  ];
  static const String url =
      "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Barney-Stinson.How-I-Met-Your-Mother.webp";

  const CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.red,
      surfaceTintColor: Colors.black,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){},
            child: SizedBox(
              height: 220,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: MainColor,
                ),
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(url),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 10),
                        child: Text(
                          "Phạm Văn Chiêu",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text("Student1401200",style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          for (final c in drawerItems)
            ListTile(
              leading: c.icon,
              title: Text(
                c.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: c.page,
                    ctx: context,
                  ),
                );
              },
            ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                backgroundColor: MainColor,
              ),
              child: GestureDetector(
                onTap: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout, color: Colors.black),
                    const SizedBox(width: 10),
                    const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
