import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class RestaurantAddBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController typeenglish = TextEditingController();
  final TextEditingController latitudecont = TextEditingController();
  final TextEditingController longitudecont = TextEditingController();
  final TextEditingController timmingenglish = TextEditingController();
  final TextEditingController descriptionenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController typearabic = TextEditingController();
  final TextEditingController timmingarabic = TextEditingController();
  final TextEditingController descriptionarabic = TextEditingController();
  final TextEditingController locationenglish = TextEditingController();
  final TextEditingController locationarabic = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();
  List<String> tags = [];
  List<File> profilepic = [];
  List<File> restopic = [];
  final loading = BoolStream();

  addresturant() async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Add Name in English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Add Name in Arabic Section !", true);
      loading.sink.add(false);
    } else if (typeenglish.text.isEmpty) {
      snack("Alert !", "Please Add Type in English Section !", true);
      loading.sink.add(false);
    } else if (typearabic.text.isEmpty) {
      snack("Alert !", "Please Add Type in Arabic Section !", true);
      loading.sink.add(false);
    } else if (latitudecont.text.isEmpty) {
      snack("Alert !", "Please Add Latitude !", true);
      loading.sink.add(false);
    } else if (longitudecont.text.isEmpty) {
      snack("Alert !", "Please Add Longitude !", true);
      loading.sink.add(false);
    } else if (timmingenglish.text.isEmpty) {
      snack("Alert !", "Please Add Timing in English Section !", true);
      loading.sink.add(false);
    } else if (timmingarabic.text.isEmpty) {
      snack("Alert !", "Please Add Timing in Arabic Section !", true);
      loading.sink.add(false);
    } else if (descriptionenglish.text.isEmpty) {
      snack("Alert !", "Please Add Description in English Section !", true);
      loading.sink.add(false);
    } else if (descriptionarabic.text.isEmpty) {
      snack("Alert !", "Please Add Description in Arabic Section !", true);
      loading.sink.add(false);
    } else if (locationenglish.text.isEmpty) {
      snack("Alert !", "Please Add Location in English Section !", true);
      loading.sink.add(false);
    } else if (locationarabic.text.isEmpty) {
      snack("Alert !", "Please Add Location in Arabic Section !", true);
      loading.sink.add(false);
    } else if (tags.isEmpty) {
      snack("Alert !", "Please Select Tags !", true);
      loading.sink.add(false);
    } else if (profilepic.isEmpty) {
      snack("Alert !", "Please Select Profile Image !", true);
      loading.sink.add(false);
    } else if (restopic.isEmpty) {
      snack("Alert !", "Please Select Restaurant Image !", true);
      loading.sink.add(false);
    } else if (numbercontroller.text.isEmpty) {
      snack("Alert !", "Please Add Number in Count Field !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.addresturantfire(
        int.parse(numbercontroller.text),
        nameenglish.text,
        namearabic.text,
        typeenglish.text,
        typearabic.text,
        latitudecont.text,
        longitudecont.text,
        timmingenglish.text,
        timmingarabic.text,
        descriptionenglish.text,
        descriptionarabic.text,
        locationenglish.text,
        locationarabic.text,
        tags,
        profilepic,
        restopic,
      ).then((bool success) {
        if (!success) {
          snack("Alert !", "This Resturant is Already Added !", true);
          loading.sink.add(false);
        } else {
          loading.sink.add(false);
          Get.back();
        }
      });
    }
  }
}
