import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/model/user.dart';

import '../component/toLogin.dart';
import '../data_type/drawer_data.dart';

import '../page/account/profile_page.dart';
import '../shared/shared.dart';

class CustomDrawer extends StatelessWidget {
  static List<DrawerData> drawerItems = [
    DrawerData(name: 'Home', icon: const Icon(Icons.home), page: "/home"),
    DrawerData(name: 'Resgister subject', icon: const Icon(Icons.home), page: "/register"),
    DrawerData(name: "Discuss", icon: Icon(Icons.chat_bubble), page: "/discuss"),
    DrawerData(name: "View process", icon: Icon(Icons.list), page: "/process"),
    DrawerData(name: 'Time table', icon: const Icon(Icons.calendar_month), page: "/timeTable"),
    DrawerData(name: 'Mark report', icon: const Icon(Icons.view_comfortable), page: "/mark"),
  ];



  CustomDrawer({Key? key});

  String userName = '';
  String studentCode = '';
  String url = '';

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString("userInfo");

    if (userJson != null) {
      User data = User.fromJson(jsonDecode(userJson));
      userName = data.name!;
      studentCode = data.code!;
      url = "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg";
    } else {
      url = "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    String? current = ModalRoute.of(context)?.settings.name;
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Drawer();
        } else {
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
                                userName,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(studentCode, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                for (final c in drawerItems)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      color: current == c.page ? blurColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: c.icon,
                      title: Text(
                        c.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      onTap: () async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove("refreshToken");
                        toLogin(context);

                      },
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
      },
    );
  }
}
