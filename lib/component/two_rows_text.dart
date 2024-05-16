import 'package:flutter/material.dart';

class TwoRowText extends StatelessWidget{
  TwoRowText({required this.name,required this.value});
final  String name;
final String value;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        Text(value,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ],
    );
  }
}