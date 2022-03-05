import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class DishEditBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController descriptionenglish = TextEditingController();
  final TextEditingController descriptionarabic = TextEditingController();
  final TextEditingController price = TextEditingController();
  List<String> tags = [];
  List<File> photos = [];
  List<String> urlstr = [];
  final loading = BoolStream();
  final delloading = BoolStream();

  initfunction(
    String nameeng,
    String nameara,
    String desceng,
    String descara,
    String priceinit,
    List<String> taginit,
    List<String> urls,
  ) {
    nameenglish.text = nameeng;
    namearabic.text = nameara;
    descriptionenglish.text = desceng;
    descriptionarabic.text = descara;
    price.text = priceinit;
    tags = taginit;
    urlstr = urls;
  }

  editdishe(String id) async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Add Name in English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Add Name in Arabic Section !", true);
      loading.sink.add(false);
    }
    if (descriptionenglish.text.isEmpty) {
      snack("Alert !", "Please Add Description in English Section !", true);
      loading.sink.add(false);
    } else if (descriptionarabic.text.isEmpty) {
      snack("Alert !", "Please Add Description in Arabic Section !", true);
      loading.sink.add(false);
    } else if (price.text.isEmpty) {
      snack("Alert !", "Please Add Price !", true);
      loading.sink.add(false);
    } else if (tags.isEmpty) {
      snack("Alert !", "Please Select Tags !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editdishefire(
        id,
        nameenglish.text,
        namearabic.text,
        descriptionenglish.text,
        descriptionarabic.text,
        price.text,
        tags,
        photos,
        urlstr,
      );
      loading.sink.add(false);
      snack("Success", "Dish Updated Successfully.", false);
    }
  }

  deletedish(String id) async {
    delloading.sink.add(true);
    await FirebaseHelper.deletedishfire(id, urlstr);
    delloading.sink.add(false);
    Get.back();
  }
}
