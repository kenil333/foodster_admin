import 'package:flutter/material.dart';

import './../../domain/all.dart';

BoxDecoration containerdeco = BoxDecoration(
  color: whit,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      offset: const Offset(0, 10),
      blurRadius: 20,
      color: txtcol.withOpacity(0.23),
    ),
  ],
);

TextStyle timingstyle(double size) {
  return TextStyle(
    fontSize: size,
    color: txtcol,
    fontWeight: FontWeight.w500,
  );
}
