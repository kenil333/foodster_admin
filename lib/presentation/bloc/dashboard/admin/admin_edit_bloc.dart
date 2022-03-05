import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../../domain/all.dart';

class AdminEditBloc {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String usertype = "";
  String resto = "";
  final loading = BoolStream();

  initfunction(
    String namei,
    String emaili,
    String passwordi,
    String usert,
    String restoi,
  ) {
    name.text = namei;
    email.text = emaili;
    password.text = passwordi;
    usertype = usert;
    resto = restoi;
  }

  editadmin(String id) async {
    loading.sink.add(true);
    if (name.text.isEmpty) {
      snack("Alert !", "Please Insert Name !", true);
      loading.sink.add(false);
    } else if (email.text.isEmpty) {
      snack("Alert !", "Please Insert Email !", true);
      loading.sink.add(false);
    } else if (password.text.isEmpty) {
      snack("Alert !", "Please Insert Password !", true);
      loading.sink.add(false);
    } else if (usertype.isEmpty) {
      snack("Alert !", "Please Select User Type !", true);
      loading.sink.add(false);
    } else if (resto.isEmpty) {
      snack("Alert !", "Please Select Restaurant !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.editadminfire(
        id,
        name.text,
        usertype,
        resto,
      );
      loading.sink.add(false);
      snack("Success", "Admin User Detail Updated Successfully.", false);
    }
  }

  deleteadmin(String id) async {
    await FirebaseHelper.deleteadminfire(id);
    Get.back();
  }
}
