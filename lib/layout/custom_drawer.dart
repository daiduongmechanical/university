import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../data_type/drawer_data.dart';

import '../page/account/profile_page.dart';
import '../shared/shared.dart';

class CustomDrawer extends StatelessWidget {
  static List<DrawerData> drawerItems = [
    DrawerData(name: 'Home', icon: const Icon(Icons.home), page: "/home"),
    DrawerData(
        name: 'Resgister subject',
        icon: const Icon(Icons.home),
        page: "/register"),
    DrawerData(
        name: "Discuss", icon: Icon(Icons.chat_bubble), page: "/discuss"),

    DrawerData(
        name: "View process", icon: Icon(Icons.list), page: "/process"),
    DrawerData(
        name: 'Time table',
        icon: const Icon(Icons.calendar_month),
        page: "/timeTable"),
    DrawerData(
        name: 'Mark report',
        icon: const Icon(Icons.view_comfortable),
        page: "/mark"),
  ];

  static const String url =
      "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Barney-Stinson.How-I-Met-Your-Mother.webp";

  const CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    String? current = ModalRoute.of(context)?.settings.name;
    return Drawer(
      backgroundColor: Colors.white,
      shadowColor: Colors.red,
      surfaceTintColor: Colors.black,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
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
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Phạm Văn Chiêu",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text("Student1401200",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          for (final c in drawerItems)
            Container(
              width: MediaQuery.of(context).size.width*0.65,
              decoration: BoxDecoration(
                  color: current == c.page ? blurColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),

              ),
              
              child: ListTile(
                leading: c.icon,
                title: Text(
                  c.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Scaffold.of(context).closeEndDrawer();
                  Navigator.pushNamed(context, c.page);
                },
              ),
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
                onTap: () {},
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
