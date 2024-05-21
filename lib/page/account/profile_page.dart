import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/model/login_data.dart';

import '../../component/custom_filled_button.dart';
import '../../component/custom_text_field.dart';
import '../../component/input_custom.dart';
import '../../layout/no_drawer_layout.dart';
import '../../shared/shared.dart';

import '../homepage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() {
    return _profilePageState();
  }
}


class _profilePageState extends State<ProfilePage> {
  bool checked = false;
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;

    });
  }

  @override
  Widget build(BuildContext context) {
    return NoDrawerLayout(
      headText: 'Profile',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Image.asset("assets/images/logo.png",
                      width: 150, height: 150),
                ),
              ),
              // CustomFilledButton(
              //   text: 'Login',
              //   onTap: _handleTap,
              // )
            ],
          ),
        ),
      ),
    );
  }

}
