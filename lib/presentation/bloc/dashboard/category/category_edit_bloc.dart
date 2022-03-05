import 'dart:io';

import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class CategoryEditBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController numbercontrol = TextEditingController();
  List<String> taglist = [];
  String? displaytype;
  File? image;
  final loading = BoolStream();

  initfunction(
    int number,
    String nameeng,
    String nameara,
    List<String> list,
    String display,
  ) {
    numbercontrol.text = number.toString();
    nameenglish.text = nameeng;
    namearabic.text = nameara;
    taglist = list;
    displaytype = display;
  }

  editcategory(String id) async {
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
    } else if (numbercontrol.text.isEmpty) {
      snack("Alert !", "Please Add Number in Count Field !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editcategoryfire(
        id,
        int.parse(numbercontrol.text),
        nameenglish.text,
        namearabic.text,
        taglist,
        displaytype!,
        image,
      );
      loading.sink.add(false);
      snack("Success", "Category Updated Successfully.", false);
    }
  }
}
