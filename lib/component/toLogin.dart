import 'package:flutter/material.dart';
import 'package:university/page/login_page.dart';

void toLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

