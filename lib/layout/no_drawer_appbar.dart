
import 'package:flutter/material.dart';

import '../shared/shared.dart';

AppBar NoDrawerAppbar(
    BuildContext context, {
      required String text,
    }) {
  return AppBar(
    backgroundColor: MainColor,
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        size: 26,
        color: Colors.black,
      ),
      onPressed: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop(false);
        }
      },
    ),

  );
}
