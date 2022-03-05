import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class LoginBloc {
  final TextEditingController email = TextEditingController();
  final TextEditingController passweod = TextEditingController();
  final loading = BoolStream();

  login(Function forward, Function store) async {
    loading.sink.add(true);
    if (email.text.isEmpty) {
      snack("Alert !", "Please Insert Email !", true);
      loading.sink.add(false);
    } else if (passweod.text.isEmpty) {
      snack("Alert !", "Please Insert Password !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.loginfire(email.text, passweod.text, store).then(
        (String result) async {
          if (result == "Go") {
            loading.sink.add(false);
            forward();
          } else {
            snack("Alert !", result, true);
            loading.sink.add(false);
          }
        },
      );
    }
  }
}
