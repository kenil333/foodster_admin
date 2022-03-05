import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class ForgotBloc {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final loading = BoolStream();

  forgotpass() async {
    loading.sink.add(true);
    if (email.text.isEmpty) {
      snack("Alert !", "Please Insert Email !", true);
      loading.sink.add(false);
    } else if (password.text.isEmpty) {
      snack("Alert !", "Please Insert Password !", true);
      loading.sink.add(false);
    } else if (confirmpassword.text != password.text) {
      snack("Alert !", "Both the Password should be Same !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.forgotfire(email.text, password.text).then(
        (bool success) {
          if (!success) {
            snack("Alert !", "Email Id not found !", true);
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
