import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../component/custom_filled_button.dart';
import '../component/custom_text_field.dart';
import '../component/input_custom.dart';
import '../layout/no_drawer_layout.dart';
import '../shared/shared.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<LoginPage> {
  bool checked = false;
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return NoDrawerLayout(
      headText: 'Login',
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
      InputCustom(
        hintText: 'Enter student code',
        labelText: 'Student code',
        controller: nameController,
      ),
              InputCustom(
                hintText: 'Enter password',
                labelText: 'Password',
                controller: passController,
                isPassword: true,
                notNull: true,
              ),
          
              Padding(
                padding: const EdgeInsets.only(bottom: 10,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: checked,
                          onChanged: (bool? value) {
                            setState(() {
                              checked = !checked;
                            });
                          },
                        ),
                        Text("Remember"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: HomePage(),
                                ctx: context,
                              ),
                            );
                          },
                          child: const Text(
                            style: TextStyle(color: Colors.red),
                            'Forgot Password',
                          )),
                    )
                  ],
                ),
              ),
              CustomFilledButton(
                text: 'Login',
                onTap: test,
              )
            ],
          ),
        ),
      ),
    );
  }

  void test() {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  _handleTap() async {
    String useUrl = '$mainURL/api/login';
    var url = Uri.parse(useUrl);
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email":"teacher", "password" :"1"}';
    var response = await http.post(url, headers: headers, body: json);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("jwt", response.body);
      print(response.body);
      prefs.setInt("id", 5);
    }
  }
}
