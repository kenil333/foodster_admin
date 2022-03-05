import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class PageAddBloc {
  final TextEditingController titleenglish = TextEditingController();
  final TextEditingController titlearabic = TextEditingController();
  final TextEditingController contentenglish = TextEditingController();
  final TextEditingController contentarabic = TextEditingController();
  final loading = BoolStream();

  addpage() async {
    loading.sink.add(true);
    if (titleenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Title from English Section !", true);
      loading.sink.add(false);
    } else if (titlearabic.text.isEmpty) {
      snack("Alert !", "Please Insert Title from Arabic Section !", true);
      loading.sink.add(false);
    } else if (contentenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Content from English Section !", true);
      loading.sink.add(false);
    } else if (contentarabic.text.isEmpty) {
      snack("Alert !", "Please Insert Content from Arabic Section !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.addpagefire(
        titleenglish.text,
        titlearabic.text,
        contentenglish.text,
        contentarabic.text,
      ).then(
        (bool success) {
          if (!success) {
            snack("Alert !", "This Page is Already Added !", true);
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
