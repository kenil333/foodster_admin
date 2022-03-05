import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class AdminAddBloc {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confpassword = TextEditingController();
  String usertype = "";
  String resto = "";
  bool sendlogin = false;
  final loading = BoolStream();

  addadmin() async {
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
    } else if (password.text != confpassword.text) {
      snack("Alert !", "Both Password Field should be Same !", true);
      loading.sink.add(false);
    } else if (usertype.isEmpty) {
      snack("Alert !", "Please Select User Type !", true);
      loading.sink.add(false);
    } else if (resto.isEmpty) {
      snack("Alert !", "Please Select Restaurant !", true);
      loading.sink.add(false);
    } else {
      await FirebaseHelper.addadminfire(
        email.text,
        password.text,
        name.text,
        usertype,
        resto,
        DateFormat("yyyyMMdd").format(DateTime.now()),
      ).then((bool success) async {
        if (!success) {
          snack("Alert !", "This Email is Already in used !", true);
          loading.sink.add(false);
        } else {
          loading.sink.add(false);
          Get.back();
          if (sendlogin) {
            final Email _sentemail = Email(
              body:
                  'Please Find your credential for Foodster Admin App.\n\n\nemail : ${email.text}\npassword : ${password.text}',
              subject: "Credential",
              recipients: [email.text],
              isHTML: false,
            );
            await FlutterEmailSender.send(_sentemail);
          }
        }
      });
    }
  }
}
