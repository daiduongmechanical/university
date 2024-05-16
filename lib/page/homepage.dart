import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../layout/normal_layout.dart';
import 'test_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NormalLayout(
      headText: 'home page',
      child: Column(
        children: [

          FilledButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(false);
              }
            },
            child: Text('back to previous page'),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "hello"
            ),
          ),
    TextFormField(

    decoration: const InputDecoration(
    icon: Icon(Icons.person),
    hintText: 'What do people call you?',
    labelText: 'Name *',
    ),
    )
        ],
      ),
    );
  }
}
