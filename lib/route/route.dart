import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:university/page/discuss_page.dart';
import 'package:university/page/list_class_attend_page.dart';
import 'package:university/page/mark_report_page.dart';
import 'package:university/page/time_table_page.dart';
import 'package:university/page/RegisterSubject/subject_register_page.dart';
import 'package:university/page/homepage.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/discuss':
      return PageTransition(
        child: ListClassAttend(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case '/timeTable':
      return PageTransition(
        child: TimeTablePage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case '/mark':
      return PageTransition(
        child: MarkReportPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case '/register':
      return PageTransition(
        child: RegisterPage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case '/home':
      return PageTransition(
        child: HomePage(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    default:
      return null;
  }
}