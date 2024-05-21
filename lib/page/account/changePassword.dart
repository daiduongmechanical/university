import 'package:flutter/material.dart';
import 'package:university/component/custom_filled_button.dart';
import 'package:university/layout/normal_layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../component/input_custom.dart';
import '../../shared/shared.dart';




class ChangePasswordScreen extends StatelessWidget {
  final String email;
  ChangePasswordScreen({required this.email});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _changePassword() async {
      if (_formKey.currentState!.validate()) {
        if (passwordController.text != confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Passwords do not match')));
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changing Password...')),
        );

        try {
          await changePassword(email, passwordController.text);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully')));
          Navigator.pushReplacementNamed(context, '/login');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    return NormalLayout(
      headText: "Change Password",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputCustom(
              hintText: 'Enter new password',
              labelText: 'New Password',
              controller: passwordController,
              isPassword: true,
              notNull: true,
            ),
            InputCustom(
              hintText: 'Confirm new password',
              labelText: 'Confirm Password',
              controller: confirmPasswordController,
              isPassword: true,
              notNull: true,
            ),
            CustomFilledButton(text: "Change Password", onTap: _changePassword),
          ],
        ),
      ),
    );
  }

  Future<void> changePassword(String email, String password) async {
    final response = await http.post(
      Uri.parse("$mainURL/flutter/change-password"),
      body: jsonEncode({'email': email, 'newPassword': password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to change password');
    }
  }
}
