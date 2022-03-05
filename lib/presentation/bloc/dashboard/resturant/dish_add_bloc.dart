import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class DishAddBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController descriptionenglish = TextEditingController();
  final TextEditingController descriptionarabic = TextEditingController();
  final TextEditingController price = TextEditingController();
  List<String> tags = [];
  List<File> photos = [];
  final loading = BoolStream();

  adddishe(String restoid) async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Add Name in English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Add Name in Arabic Section !", true);
      loading.sink.add(false);
    } else if (descriptionenglish.text.isEmpty) {
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
    } else if (photos.isEmpty) {
      snack("Alert !", "Please Select Image !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.adddishfire(
        restoid,
        nameenglish.text,
        namearabic.text,
        descriptionenglish.text,
        descriptionarabic.text,
        price.text,
        tags,
        photos,
      ).then((bool success) {
        if (!success) {
          snack("Alert !", "This Dish is Already Added !", true);
          loading.sink.add(false);
        } else {
          loading.sink.add(false);
          Get.back();
        }
      });
    }
  }
}
