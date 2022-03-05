import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class BannerAddBloc {
  final TextEditingController name = TextEditingController();
  String startdate = "";
  String enddate = "";
  File? image;
  final loading = BoolStream();

  addbanner() async {
    loading.sink.add(true);
    if (name.text.isEmpty) {
      snack("Alert !", "Please Add Name !", true);
      loading.sink.add(false);
    } else if (image == null) {
      snack("Alert !", "Please Select an Image !", true);
      loading.sink.add(false);
    } else if (startdate.isEmpty) {
      snack("Alert !", "Please Select Start Date !", true);
      loading.sink.add(false);
    } else if (enddate.isEmpty) {
      snack("Alert !", "Please Select End Time !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.addbannerfire(
        name.text,
        startdate,
        enddate,
        image!,
      ).then(
        (bool success) {
          if (!success) {
            snack("Alert !", "This Banner is Already Added !", true);
            loading.sink.add(false);
          } else {
            loading.sink.add(false);
            Get.back();
          }
        },
      );
    }
  }
}
