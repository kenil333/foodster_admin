import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class NotificationAddBloc {
  final TextEditingController nameenglish = TextEditingController();
  final TextEditingController namearabic = TextEditingController();
  final TextEditingController messageenglish = TextEditingController();
  final TextEditingController messagearabic = TextEditingController();
  String date = "";
  String time = "";
  final loading = BoolStream();

  addnotification() async {
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
      await FirebaseHelper.addnotificationfire(
        nameenglish.text,
        namearabic.text,
        messageenglish.text,
        messagearabic.text,
        date,
        time,
      ).then((bool success) {
        if (!success) {
          snack("Alert !", "This Notification is Already Added !", true);
          loading.sink.add(false);
        } else {
          loading.sink.add(false);
          Get.back();
        }
      });
    }
  }
}
