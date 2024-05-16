


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../shared/shared.dart';
import 'login_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Navigate to SecondScreen
        ),
      );
    });


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
                body: Column(children: [
          Expanded(
              flex: 2,
              child: Image.asset("assets/images/logo.png",
                  width: 280, height: 280)),
          Expanded(
              child: Container(padding: const EdgeInsets.only(bottom: 100),
                child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                Text(
                  "Plase Waiting",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: MainColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.black,
                    size: 40,
                  ),
                )
                            ],
                          ),
              ))
        ]))));
  }
}
