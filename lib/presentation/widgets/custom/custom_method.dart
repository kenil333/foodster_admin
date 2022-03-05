import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import './../../../domain/all.dart';

appbarpref(bool dark, Color color) {
  return PreferredSize(
    child: AppBar(
      backgroundColor: color,
      systemOverlayStyle:
          dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      elevation: 0,
    ),
    preferredSize: const Size.fromHeight(0),
  );
}

routepushreplash(BuildContext context, Widget widget) {
  return Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

routepush(BuildContext context, Widget widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

loadingwidget() {
  return const Center(
    child: SpinKitSpinningLines(
      color: primarycol,
    ),
  );
}

nodatafound() {
  return Center(
    child: Image.asset(dnfimg, width: 250, fit: BoxFit.contain),
  );
}

snack(String title, String message, bool red) {
  return Get.snackbar(
    title,
    message,
    colorText: whit,
    backgroundColor: red ? redcolor : greencol,
    snackPosition: SnackPosition.BOTTOM,
  );
}

Future<File?> chooseimage() async {
  final _picker = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (_picker != null) {
    return File(_picker.path);
  }
  return null;
}

Future<DateTime?> pickthedate(BuildContext context) async {
  final DateTime? _date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.parse("20220101"),
    lastDate: DateTime.now().add(const Duration(days: 300)),
  );
  return _date;
}

Future<TimeOfDay?> pickthetime(BuildContext context) async {
  final TimeOfDay? _pickedtime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return _pickedtime;
}

showremovedilog(Size size, BuildContext context, Function remove) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
        ),
        decoration: BoxDecoration(
          color: whit,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Text(
              "Are you want to delete ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: redcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    size: size,
                    title: "No",
                    func: () {
                      Navigator.of(context).pop();
                    },
                    removespace: true,
                    color: greencol,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Expanded(
                  child: CustomButton(
                    size: size,
                    title: "Yes",
                    func: () {
                      remove();
                      Navigator.of(context).pop();
                    },
                    removespace: true,
                    color: redcolor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
