import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomHomeMenuBtn extends StatelessWidget {
  final Size size;
  final BuildContext ctx;
  const CustomHomeMenuBtn({
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
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Navigator.popUntil(
                    ctx,
                    (Route<dynamic> predicate) => predicate.isFirst,
                  );
                },
                child: Icon(
                  Icons.menu,
                  size: size.width * 0.068,
                  color: whit,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
