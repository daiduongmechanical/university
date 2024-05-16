import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/shared.dart';

class InputCustom extends StatelessWidget {
   InputCustom(
      {super.key,
      required this.hintText,
        this.isPassword=false,
        this.notNull=false,
      required this.labelText,
      required this.controller,});

  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final bool notNull;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null && notNull || value!.isEmpty && notNull) {
            return 'Please enter some text';
          }
          return null;
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: BorderColor, width: 1.5),
          ),
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MainColor, width: 1.5),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
