import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class SigninImgWid extends StatelessWidget {
  final Size size;
  const SigninImgWid({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        signiniconimg,
        fit: BoxFit.contain,
        width: size.width * 0.7,
      ),
    );
  }
}
