import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

import './../../../../domain/all.dart';

class AnalysticBloc {
  final TextEditingController email = TextEditingController();

  List<AnalysticModel> _list = [];

  setlist(List<AnalysticModel> fromlist) {
    _list = fromlist;
  }

  exportcsv() async {
    if (email.text.isNotEmpty && _list.isNotEmpty) {
      List<List<dynamic>> _rows = [];
      List<dynamic> _indicatedrow = [];
      _indicatedrow.add("Restaurant Name");
      _indicatedrow.add("Restaurant View");
      _indicatedrow.add("Restaurant Bookmarks");
      _indicatedrow.add("Restaurant Share");
      _indicatedrow.add("Restaurants Map Click");
      _indicatedrow.add("Dishes View");
      _indicatedrow.add("Dishes Bookmarks");
      _rows.add(_indicatedrow);
      for (int j = 0; j < _list.length; j++) {
        List<dynamic> _row = [];
        _row.add(_list[j].name);
        _row.add(_list[j].restoview.length.toString());
        _row.add(_list[j].restobookmark.length.toString());
        _row.add(_list[j].share.length.toString());
        _row.add(_list[j].mapclick.length.toString());
        _row.add(_list[j].dishview.length.toString());
        _row.add(_list[j].dishbookmark.length.toString());
        _rows.add(_row);
      }
      String _csv = const ListToCsvConverter().convert(_rows);
      Directory _temp = await getTemporaryDirectory();
      final String _path = "${_temp.path}/${DateTime.now().millisecond}.csv";
      final File _file = File(_path);
      await _file.writeAsString(_csv).then((value) async {
        final Email _sentemail = Email(
          body: 'Please Find the CSV file for the Restaurant Report.',
          subject: "Restaurant Report",
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
      } else {
        snack(
          "Alert !",
          "List is Empty !",
          true,
        );
      }
    }
  }
}
