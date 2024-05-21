import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../../component/two_rows_text.dart';
import '../../layout/normal_layout.dart';
import '../../model/mark.dart';
import '../../shared/shared.dart';



class DetailMarkPage extends StatefulWidget {
  DetailMarkPage({required this.data});

  final Mark data;

  @override
  _DetailMarkPageState createState() => _DetailMarkPageState();
}

class _DetailMarkPageState extends State<DetailMarkPage> {
  @override
  Widget build(BuildContext context) {
    return NormalLayout(
      headText: 'Mark details',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  widget.data.name ?? "Default",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Semester ${widget.data.semester}',
                value: '${widget.data.year} - ${widget.data.year! + 1}',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Teacher',
                value: widget.data.teacher ?? 'Default',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Class',
                value: widget.data.classData ?? 'Default',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Regular point',
                value: '${widget.data.normalMark}',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Middle point',
                value: '${widget.data.middleMark}',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Final point',
                value: '${widget.data.finalMark}',
              ),
            ),
            Expanded(
              flex: 1,
              child: TwoRowText(
                name: 'Average point',
                value: '${widget.data.averageMark}',
              ),
            ),
            Expanded(
              flex: 1,
              child: AnimatedButton(
                text: "Register again",
                width: MediaQuery.of(context).size.width * 0.6,
                color: MainColor,
                pressEvent: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    title: "Warning",
                    desc: "Are you sure you want to register again for this subject?",
                    btnOkOnPress: () {
                      // Add your logic for registering again
                    },
                    btnCancelOnPress: () {},
                  ).show();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
