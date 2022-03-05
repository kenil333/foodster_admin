import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomBackBtn extends StatelessWidget {
  final Size size;
  final BuildContext ctx;
  const CustomBackBtn({
    Key? key,
    required this.size,
    required this.ctx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: size.width * 0.058,
                  color: whit,
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
