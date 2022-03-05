import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class PushNotificationAddScreen extends StatefulWidget {
  const PushNotificationAddScreen({Key? key}) : super(key: key);

  @override
  State<PushNotificationAddScreen> createState() =>
      _PushNotificationAddScreenState();
}

class _PushNotificationAddScreenState extends State<PushNotificationAddScreen> {
  final _bloc = NotificationAddBloc();
  final _language = StringStream();
  final _datestream = StringStream();
  final _timestream = StringStream();

  @override
  void dispose() {
    _language.dispose();
    _datestream.dispose();
    _timestream.dispose();
    _bloc.loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: appbarpref(false, primarycol),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.07,
            padding: const EdgeInsets.only(bottom: 6),
            color: primarycol,
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  child: Image.asset(
                    dashbordwhitimg,
                    fit: BoxFit.contain,
                  ),
                ),
                CustomHomeMenuBtn(size: size, ctx: context),
                CustomBackBtn(size: size, ctx: context),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<String?>(
              stream: _language.stream,
              initialData: englishlangstr,
              builder: (context, snap) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: selectlanguagestr,
                        language: snap.data!,
                      ),
                      CustomDropdownWidget(
                        size: size,
                        hint: selectlanguagestr,
                        mainvar: snap.data,
                        listofwidget: const [
                          englishlangstr,
                          arabiclangstr,
                        ],
                        onchange: (String? value) {
                          _language.sink.add(value);
                        },
                        language: snap.data!,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.04),
                          Expanded(
                            child: Text(
                              "Date",
                              textAlign: snap.data! == englishlangstr
                                  ? TextAlign.start
                                  : TextAlign.end,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: txtcol,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: Text(
                              "Time",
                              textAlign: snap.data! == englishlangstr
                                  ? TextAlign.start
                                  : TextAlign.end,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: txtcol,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.04),
                          Expanded(
                            child: StreamBuilder<String?>(
                              stream: _datestream.stream,
                              initialData: null,
                              builder: (context, datesnap) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: 10,
                                  ),
                                  decoration: containerdeco,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          datesnap.data == null
                                              ? ""
                                              : DateFormat("dd.MM.yyyy").format(
                                                  DateTime.parse(
                                                      datesnap.data!)),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: size.width * 0.05,
                                            color: txtcol,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final _date =
                                              await pickthedate(context);
                                          if (_date != null) {
                                            _bloc.date = DateFormat("yyyyMMdd")
                                                .format(_date);
                                            _datestream.sink.add(
                                                DateFormat("yyyyMMdd")
                                                    .format(_date));
                                          }
                                        },
                                        child: const Icon(
                                          Icons.calendar_today_rounded,
                                          color: txtcol,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: StreamBuilder<String?>(
                              stream: _timestream.stream,
                              initialData: null,
                              builder: (context, timesnap) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: 10,
                                  ),
                                  decoration: containerdeco,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          timesnap.data == null
                                              ? ""
                                              : timesnap.data!,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: size.width * 0.05,
                                            color: txtcol,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final _time =
                                              await pickthetime(context);
                                          if (_time != null) {
                                            String _hour = _time.hour
                                                        .toString()
                                                        .length ==
                                                    1
                                                ? "0${_time.hour.toString()}"
                                                : _time.hour.toString();
                                            String _minutes = _time.minute
                                                        .toString()
                                                        .length ==
                                                    1
                                                ? "0${_time.minute.toString()}"
                                                : _time.minute.toString();
                                            _bloc.time = "$_hour:$_minutes";
                                            _timestream.sink
                                                .add("$_hour:$_minutes");
                                          }
                                        },
                                        child: const Icon(
                                          Icons.timer,
                                          color: txtcol,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: namestr,
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: namestr,
                        language: snap.data!,
                        controller: snap.data == englishlangstr
                            ? _bloc.nameenglish
                            : _bloc.namearabic,
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: messagestr,
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: messagestr,
                        controller: snap.data == englishlangstr
                            ? _bloc.messageenglish
                            : _bloc.messagearabic,
                        maxline: true,
                        language: snap.data!,
                      ),
                      const SizedBox(height: 50),
                      StreamBuilder<bool>(
                        stream: _bloc.loading.stream,
                        initialData: false,
                        builder: (context, loadingsnap) {
                          if (loadingsnap.data!) {
                            return loadingwidget();
                          } else {
                            return CustomButton(
                              size: size,
                              title: "$addstr $notificationstr",
                              func: () {
                                _bloc.addnotification();
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
