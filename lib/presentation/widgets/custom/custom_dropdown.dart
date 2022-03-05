import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomDropdownWidget extends StatelessWidget {
  final Size size;
  final String hint;
  final String? mainvar;
  final List<String> listofwidget;
  final Function onchange;
  final String language;
  final bool enable;
  const CustomDropdownWidget({
    Key? key,
    required this.size,
    required this.hint,
    required this.mainvar,
    required this.listofwidget,
    required this.onchange,
    required this.language,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: 0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.width * 0.01,
        horizontal: size.width * 0.045,
      ),
      width: double.infinity,
      decoration: containerdeco,
      child: DropdownButtonHideUnderline(
        child: IgnorePointer(
          ignoring: !enable,
          child: DropdownButton(
            icon: Icon(
              enable ? Icons.arrow_downward_rounded : Icons.lock,
              color: txtcol,
            ),
            isExpanded: true,
            value: mainvar,
            style: TextStyle(
              color: txtcol,
              fontSize: size.width * 0.045,
            ),
            items: listofwidget.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                enabled: enable,
                value: value,
                child: Row(
                  children: [
                    language != englishlangstr
                        ? Expanded(child: Container())
                        : Container(),
                    Text(
                      value,
                      style: TextStyle(
                        color: txtcol,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    language == englishlangstr
                        ? Expanded(child: Container())
                        : Container(),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            }).toList(),
            hint: Text(hint),
            onChanged: (String? value) {
              onchange(value);
            },
          ),
        ),
      ),
    );
  }
}
