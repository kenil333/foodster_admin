import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import './../../../../domain/all.dart';

class AppUserBloc {
  final TextEditingController email = TextEditingController();

  List<AppUserModel> _list = [];

  setlist(List<AppUserModel> fromlist) {
    _list = fromlist;
  }

  exportcsv() async {
    if (email.text.isNotEmpty && _list.isNotEmpty) {
      List<List<dynamic>> _rows = [];
      List<dynamic> _indicatedrow = [];
      _indicatedrow.add("Name");
      _indicatedrow.add("Email");
      _indicatedrow.add("Phone Number");
      _indicatedrow.add("Account Created");
      _indicatedrow.add("Restaurants View");
      _indicatedrow.add("Restaurants Bookmarks");
      _indicatedrow.add("Dishes View");
      _indicatedrow.add("Dishes Bookmarks");
      _rows.add(_indicatedrow);
      for (int j = 0; j < _list.length; j++) {
        List<dynamic> _row = [];
        _row.add(_list[j].name);
        _row.add(_list[j].email);
        _row.add(_list[j].phone);
        _row.add(
          DateFormat("dd-MM-yyyy").format(_list[j].date),
        );
        _row.add(_list[j].restoviews);
        _row.add(_list[j].restobookmarks);
        _row.add(_list[j].dishviews);
        _row.add(_list[j].dishbookmarks);
        _rows.add(_row);
      }
      String _csv = const ListToCsvConverter().convert(_rows);
      Directory _temp = await getTemporaryDirectory();
      final String _path = "${_temp.path}/${DateTime.now().millisecond}.csv";
      final File _file = File(_path);
      await _file.writeAsString(_csv).then((value) async {
        final Email _sentemail = Email(
          body: 'Please Find the CSV file for an App User Report.',
          subject: "App User Report",
          recipients: [email.text],
          attachmentPaths: [value.path],
          isHTML: false,
        );
        await FlutterEmailSender.send(_sentemail);
      });
    } else {
      if (email.text.isEmpty) {
        snack(
          "Alert !",
          "Please Enter Email !",
          true,
        );
      }
      if (_list.isEmpty) {
        snack(
          "Alert !",
          "App User List is Empty !",
          true,
        );
      }
    }
  }
}
