import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../../../domain/all.dart';

class CustomTextfeild extends StatelessWidget {
  final Size size;
  final String hintstr;
  final TextEditingController controller;
  final bool lowmargin;
  final bool maxline;
  final String language;
  final Function? onchange;
  final bool enable;
  final bool obsecured;
  final bool number;
  final bool numberonly;
  final bool doublevalue;
  const CustomTextfeild({
    Key? key,
    required this.size,
    required this.hintstr,
    required this.controller,
    this.lowmargin = false,
    this.maxline = false,
    required this.language,
    this.onchange,
    this.enable = true,
    this.obsecured = false,
    this.number = false,
    this.numberonly = false,
    this.doublevalue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.01,
        horizontal: size.width * 0.045,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: lowmargin ? 0 : size.width * 0.05,
        vertical: 0,
      ),
      decoration: containerdeco,
      child: TextField(
        inputFormatters: numberonly
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ]
            : doublevalue
                ? [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  ]
                : null,
        keyboardType:
            number ? TextInputType.number : TextInputType.emailAddress,
        obscureText: obsecured,
        enabled: enable,
        controller: controller,
        textAlign: language == englishlangstr ? TextAlign.start : TextAlign.end,
        style: TextStyle(
          fontSize: size.width * 0.045,
          color: txtcol,
        ),
        onChanged: onchange == null
            ? null
            : (String sestring) {
                onchange!(sestring);
              },
        decoration: InputDecoration(
          hintText: hintstr,
          border: InputBorder.none,
        ),
        maxLines: maxline
            ? hintstr == contentstr
                ? 15
                : 3
            : 1,
        textInputAction: maxline ? TextInputAction.newline : null,
      ),
    );
  }
}
