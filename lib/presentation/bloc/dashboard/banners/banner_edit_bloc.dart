import 'dart:io';

import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class BannerEditBloc {
  final TextEditingController name = TextEditingController();
  String startdate = "";
  String enddate = "";
  File? image;
  final loading = BoolStream();

  initfunction(String nameinit, String sdate, String edate) {
    name.text = nameinit;
    startdate = sdate;
    enddate = edate;
  }

  editbanner(String id) async {
    loading.sink.add(true);
    if (name.text.isEmpty) {
      snack("Alert !", "Please Add Name !", true);
      loading.sink.add(false);
    } else if (startdate.isEmpty) {
      snack("Alert !", "Please Select Start Date", true);
      loading.sink.add(false);
    } else if (enddate.isEmpty) {
      snack("Alert !", "Please Select End Time", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editbannerfire(
        id,
        name.text,
        startdate,
        enddate,
        image,
      );
      loading.sink.add(false);
      snack("Success", "Banner Updated Successfully.", false);
    }
  }
}
