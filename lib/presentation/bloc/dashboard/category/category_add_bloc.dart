import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class CategoryAddBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController numbercontroll = TextEditingController();
  List<String> taglist = [];
  String? displaytype;
  File? image;
  final loading = BoolStream();
  int restol = 0;
  int dushl = 0;

  addcategory() async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Add Name in English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Add Name in Arabic Section !", true);
      loading.sink.add(false);
    } else if (taglist.isEmpty) {
      snack("Alert !", "Please Select atleast one Tag list !", true);
      loading.sink.add(false);
    } else if (displaytype == null) {
      snack("Alert !", "Please Select Display Type !", true);
      loading.sink.add(false);
    } else if (image == null) {
      snack("Alert !", "Please Select an Image !", true);
      loading.sink.add(false);
    } else if (numbercontroll.text.isEmpty) {
      snack("Alert !", "Please Add Count Number !", true);
      loading.sink.add(false);
    } else {
      String _error = "No";
      if (displaytype == restaurantsstr) {
        if ((restol % 2) == 0 && (int.parse(numbercontroll.text) % 2) == 0) {
          _error = "Please Enter only Odd number in Count Field !";
        }
        if ((restol % 2) != 0 && (int.parse(numbercontroll.text) % 2) != 0) {
          _error = "Please Enter only Even number in Count Field !";
        }
      } else {
        if ((dushl % 2) == 0 && (int.parse(numbercontroll.text) % 2) == 0) {
          _error = "Please Enter only Odd number in Count Field !";
        }
        if ((dushl % 2) != 0 && (int.parse(numbercontroll.text) % 2) != 0) {
          _error = "Please Enter only Even number in Count Field !";
        }
      }
      if (_error == "No") {
        await FirebaseHelper.addcategoryfire(
          int.parse(numbercontroll.text),
          nameenglish.text,
          namearabic.text,
          taglist,
          displaytype!,
          image!,
        ).then((bool success) {
          if (!success) {
            snack("Alert !", "This Category is Already Added !", true);
            loading.sink.add(false);
          } else {
            loading.sink.add(false);
            Get.back();
          }
        });
      } else {
        snack("Alert !", _error, true);
        loading.sink.add(false);
      }
    }
  }
}
