import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class PageEditBloc {
  final TextEditingController titleenglish = TextEditingController();
  final TextEditingController titlearabic = TextEditingController();
  final TextEditingController contentenglish = TextEditingController();
  final TextEditingController contentarabic = TextEditingController();
  final loading = BoolStream();

  initfunction(
    String tenglish,
    String tarabic,
    String cenglish,
    carabic,
  ) {
    titleenglish.text = tenglish;
    titlearabic.text = tarabic;
    contentenglish.text = cenglish;
    contentarabic.text = carabic;
  }

  editpage(String id) async {
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
      await FirebaseHelper.editpagefire(
        id,
        titleenglish.text,
        titlearabic.text,
        contentenglish.text,
        contentarabic.text,
      );
      snack("Success", "Page Updated Successfully.", false);
      loading.sink.add(false);
    }
  }
}
