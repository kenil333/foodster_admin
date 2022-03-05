import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class AdBannerAddScreen extends StatefulWidget {
  const AdBannerAddScreen({Key? key}) : super(key: key);

  @override
  State<AdBannerAddScreen> createState() => _AdBannerAddScreenState();
}

class _AdBannerAddScreenState extends State<AdBannerAddScreen> {
  final _bloc = BannerAddBloc();
  final _image = FileStream();
  final _startdatestream = StringStream();
  final _enddatestream = StringStream();

  @override
  void dispose() {
    _bloc.loading.dispose();
    _bloc.name.dispose();
    _image.dispose();
    _startdatestream.dispose();
    _enddatestream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        backgroundColor: primarycol,
        title: const Text(
          "$addstr $adbannerstr",
          style: TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> predicate) => predicate.isFirst,
              );
            },
            child: Icon(
              Icons.home_outlined,
              size: size.width * 0.068,
              color: whit,
            ),
          ),
          SizedBox(width: size.width * 0.025),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Text(
                    "From",
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
                    "To",
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
                    stream: _startdatestream.stream,
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
                                    : DateFormat("dd.MM.yyyy")
                                        .format(DateTime.parse(datesnap.data!)),
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
                                final _date = await pickthedate(context);
                                if (_date != null) {
                                  _bloc.startdate =
                                      DateFormat("yyyyMMdd").format(_date);
                                  _startdatestream.sink.add(
                                      DateFormat("yyyyMMdd").format(_date));
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
                    stream: _enddatestream.stream,
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
                                timesnap.data == null ? "" : timesnap.data!,
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
                                final _date = await pickthedate(context);
                                if (_date != null) {
                                  _bloc.enddate =
                                      DateFormat("yyyyMMdd").format(_date);
                                  _enddatestream.sink.add(
                                      DateFormat("yyyyMMdd").format(_date));
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
              language: englishlangstr,
            ),
            CustomTextfeild(
              size: size,
              hintstr: namestr,
              controller: _bloc.name,
              language: englishlangstr,
            ),
            const SizedBox(height: 15),
            CustomLable(
              size: size,
              title: adbannerstr,
              language: englishlangstr,
            ),
            StreamBuilder<File?>(
              stream: _image.stream,
              initialData: null,
              builder: (context, imagesnap) {
                return Container(
                  width: double.infinity,
                  height: size.height * 0.25,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 0,
                  ),
                  decoration: containerdeco,
                  child: imagesnap.data != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  imagesnap.data!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () async {
                                  File? _imagefile = await chooseimage();
                                  if (_imagefile != null) {
                                    _bloc.image = _imagefile;
                                    _image.sink.add(_imagefile);
                                  }
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: greencol,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 10),
                                        blurRadius: 20,
                                        color: txtcol.withOpacity(0.23),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: whit,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: InkWell(
                            onTap: () async {
                              File? _imagefile = await chooseimage();
                              if (_imagefile != null) {
                                _bloc.image = _imagefile;
                                _image.sink.add(_imagefile);
                              }
                            },
                            child: Icon(
                              Icons.add_circle,
                              size: size.width * 0.2,
                              color: greencol,
                            ),
                          ),
                        ),
                );
              },
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
                    title: "$addstr $adbannerstr",
                    func: () {
                      _bloc.addbanner();
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
