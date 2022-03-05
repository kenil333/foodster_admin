import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomButton extends StatelessWidget {
  final Size size;
  final String title;
  final Function func;
  final bool removespace;
  final Color color;
  const CustomButton({
    Key? key,
    required this.size,
    required this.title,
    required this.func,
    this.removespace = false,
    this.color = primarycol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: removespace ? 0 : size.width * 0.1,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {
          func();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: removespace ? size.height * 0.01 : size.height * 0.015,
          ),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: size.width * 0.045,
              fontFamily: secondaryfontfamily,
            ),
          ),
        ),
      ),
    );
  }
}
