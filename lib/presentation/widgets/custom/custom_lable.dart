import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomLable extends StatelessWidget {
  final Size size;
  final String title;
  final String language;
  const CustomLable({
    Key? key,
    required this.size,
    required this.title,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 5),
      alignment: language == englishlangstr
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: size.width * 0.05,
          color: txtcol,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
