import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomTitleIconBtn extends StatelessWidget {
  final Size size;
  final String title;
  final Function onclick;
  const CustomTitleIconBtn({
    Key? key,
    required this.size,
    required this.title,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclick();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: 5,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whit,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.052,
                  color: txtcol,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset(
              forwardimg,
              width: size.width * 0.052,
              fit: BoxFit.contain,
              color: primarycol,
            ),
          ],
        ),
      ),
    );
  }
}
