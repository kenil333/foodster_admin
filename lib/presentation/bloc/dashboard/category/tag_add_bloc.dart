import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class TagAddBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearebic = TextEditingController();
  final loading = BoolStream();

  addtags() async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Tag name from English Section !", true);
      loading.sink.add(false);
    } else if (namearebic.text.isEmpty) {
      snack("Alert !", "Please Insert Tag name from Arabic Section !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.addtagfire(
        nameenglish.text,
        namearebic.text,
      ).then((success) {
        if (!success) {
          snack("Alert !", "This Tag is Already Added !", true);
          loading.sink.add(false);
        } else {
          loading.sink.add(false);
          Get.back();
        }
      });
    }
  }
}
