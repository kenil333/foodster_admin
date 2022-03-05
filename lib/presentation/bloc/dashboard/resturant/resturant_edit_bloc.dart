import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class ResturantEditBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController typeenglish = TextEditingController();
  final TextEditingController longitude = TextEditingController();
  final TextEditingController latitude = TextEditingController();
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
  List<String> profileurl = [];
  List<String> restourl = [];
  List<File> profilepic = [];
  List<File> restopic = [];
  String display = "Yes";
  final loading = BoolStream();
  final delloading = BoolStream();
  List<DishModel> dishes = [];

  addintodish(List<DishModel> dlist) {
    dishes = dlist;
  }

  initfunction(
    int number,
    String nameeng,
    String nameare,
    String typeeng,
    String typeara,
    String latitudeinit,
    String longitudeinit,
    String timeeng,
    String timeara,
    String desceng,
    String descara,
    String locengi,
    String locarai,
    List<String> taginit,
    String displayinit,
    List<String> purls,
    List<String> rurls,
  ) {
    numbercontroller.text = number.toString();
    nameenglish.text = nameeng;
    namearabic.text = nameare;
    typeenglish.text = typeeng;
    typearabic.text = typeara;
    latitude.text = latitudeinit;
    longitude.text = longitudeinit;
    timmingenglish.text = timeeng;
    timmingarabic.text = timeara;
    descriptionenglish.text = desceng;
    descriptionarabic.text = descara;
    locationenglish.text = locengi;
    locationarabic.text = locarai;
    tags = taginit;
    display = displayinit;
    profileurl = purls;
    restourl = rurls;
  }

  editresturant(String id) async {
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
    } else if (latitude.text.isEmpty) {
      snack("Alert !", "Please Add Latitude !", true);
      loading.sink.add(false);
    } else if (longitude.text.isEmpty) {
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
    } else if (numbercontroller.text.isEmpty) {
      snack("Alert !", "Please Add Number in Count Field !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editresturantfire(
        id,
        int.parse(numbercontroller.text),
        nameenglish.text,
        namearabic.text,
        typeenglish.text,
        typearabic.text,
        latitude.text,
        longitude.text,
        timmingenglish.text,
        timmingarabic.text,
        descriptionenglish.text,
        descriptionarabic.text,
        locationenglish.text,
        locationarabic.text,
        tags,
        profilepic,
        restopic,
        profileurl,
        restourl,
        display,
      );
      loading.sink.add(false);
      snack("Success", "Resturant Updated Successfully.", false);
    }
  }

  deleteresto(String id) async {
    delloading.sink.add(true);
    await FirebaseHelper.deleteresturatfire(id, profileurl, restourl, dishes);
    delloading.sink.add(false);
    Get.back();
  }
}
