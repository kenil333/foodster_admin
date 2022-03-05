import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class TagEditBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final loading = BoolStream();

  initfunction(String english, String arabic) {
    nameenglish.text = english;
    namearabic.text = arabic;
  }

  edittag(String id) async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Tag name from English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Insert Tag name from Arabic Section !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.edittagfire(id, nameenglish.text, namearabic.text);
      loading.sink.add(false);
      snack("Success", "Tag Updated Successfully.", false);
    }
  }
}
