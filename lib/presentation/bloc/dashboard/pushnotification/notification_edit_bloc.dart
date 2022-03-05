import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class NotificationEditBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController messageenglish = TextEditingController();
  final TextEditingController messagearabic = TextEditingController();
  String date = "";
  String time = "";
  final loading = BoolStream();

  initfunction(
    String nenglish,
    String narabic,
    String menglish,
    String marabic,
    String dateinit,
    String timeinit,
  ) {
    nameenglish.text = nenglish;
    namearabic.text = narabic;
    messageenglish.text = menglish;
    messagearabic.text = marabic;
    date = dateinit;
    time = timeinit;
  }

  editnotification(String id) async {
    loading.sink.add(true);
    if (nameenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Name from English Section !", true);
      loading.sink.add(false);
    } else if (namearabic.text.isEmpty) {
      snack("Alert !", "Please Insert Name from Arabic Section !", true);
      loading.sink.add(false);
    } else if (messageenglish.text.isEmpty) {
      snack("Alert !", "Please Insert Message from English Section !", true);
      loading.sink.add(false);
    } else if (messagearabic.text.isEmpty) {
      snack("Alert !", "Please Insert Message from Arabic Section !", true);
      loading.sink.add(false);
    } else if (date.isEmpty) {
      snack("Alert !", "Please Select Date !", true);
      loading.sink.add(false);
    } else if (time.isEmpty) {
      snack("Alert !", "Please Select Time !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editnotificationfire(
        id,
        nameenglish.text,
        namearabic.text,
        messageenglish.text,
        messagearabic.text,
        date,
        time,
      );
      snack("Success", "Notification Updated Successfully.", false);
      loading.sink.add(false);
    }
  }
}
