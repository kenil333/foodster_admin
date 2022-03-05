import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class AnalysticScreen extends StatefulWidget {
  final String usertype;
  final String resto;
  const AnalysticScreen({
    Key? key,
    required this.usertype,
    required this.resto,
  }) : super(key: key);

  @override
  State<AnalysticScreen> createState() => _AnalysticScreenState();
}

class _AnalysticScreenState extends State<AnalysticScreen> {
  final _bloc = AnalysticBloc();
  final _fromdate = StringStream();
  final _todate = StringStream();
  final _retoindex = IntStream();

  @override
  void dispose() {
    _fromdate.dispose();
    _todate.dispose();
    _retoindex.dispose();
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder(
                  stream: FirebaseHelper.resturantstream(),
                  builder: (context, firesnap) {
                    if (firesnap.connectionState == ConnectionState.waiting) {
                      return loadingwidget();
                    } else if ((firesnap.data as DatabaseEvent)
                                .snapshot
                                .value !=
                            null &&
                        firesnap.hasData &&
                        !firesnap.hasError) {
                      List<AnalysticModel> _list = [];
                      List<String> _namelist = ["All"];
                      int _restoview = 0;
                      int _dishview = 0;
                      int _restobookmark = 0;
                      int _dishbookmark = 0;
                      int _share = 0;
                      int _mapclick = 0;
                      final Map _data = ((firesnap.data as DatabaseEvent)
                          .snapshot
                          .value as Map);
                      _data.forEach((key, value) {
                        _list.add(AnalysticModel.formfire(key, value));
                      });
                      for (int i = 0; i < _list.length; i++) {
                        _namelist.add(_list[i].name);
                        _restoview += _list[i].restoview.length;
                        _dishview += _list[i].dishview.length;
                        _restobookmark += _list[i].restobookmark.length;
                        _dishbookmark += _list[i].dishbookmark.length;
                        _share += _list[i].share.length;
                        _mapclick += _list[i].mapclick.length;
                      }
                      _bloc.setlist(_list);
                      return StreamBuilder<String?>(
                        stream: _fromdate.stream,
                        initialData: null,
                        builder: (context, fromsnap) => StreamBuilder<String?>(
                          stream: _todate.stream,
                          initialData: null,
                          builder: (context, tosnap) => StreamBuilder<int?>(
                            stream: _retoindex.stream,
                            initialData: widget.resto == "Super" ||
                                    widget.resto == "All Restaurants"
                                ? 0
                                : _namelist.indexWhere(
                                    (e) =>
                                        e ==
                                        _list[_list.indexWhere(
                                                (ei) => ei.id == widget.resto)]
                                            .name,
                                  ),
                            builder: (context, indexsnap) {
                              int _rview = 0;
                              int _dview = 0;
                              int _rbookmark = 0;
                              int _dbookmark = 0;
                              int _s = 0;
                              int _m = 0;
                              if (fromsnap.data != null &&
                                  tosnap.data != null) {
                                final _start =
                                    DateTime.parse(fromsnap.data!).subtract(
                                  const Duration(days: 1),
                                );
                                final _end = DateTime.parse(tosnap.data!).add(
                                  const Duration(days: 1),
                                );
                                if (_start.isBefore(_end)) {
                                  if (_namelist[indexsnap.data!] == "All") {
                                    for (int j = 0; j < _list.length; j++) {
                                      for (int i = 0;
                                          i < _list[j].restoview.length;
                                          i++) {
                                        if (_list[j]
                                                .restoview[i]
                                                .isBefore(_end) &&
                                            _list[j]
                                                .restoview[i]
                                                .isAfter(_start)) {
                                          _rview++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < _list[j].dishview.length;
                                          i++) {
                                        if (_list[j]
                                                .dishview[i]
                                                .isBefore(_end) &&
                                            _list[j]
                                                .dishview[i]
                                                .isAfter(_start)) {
                                          _dview++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < _list[j].restobookmark.length;
                                          i++) {
                                        if (_list[j]
                                                .restobookmark[i]
                                                .isBefore(_end) &&
                                            _list[j]
                                                .restobookmark[i]
                                                .isAfter(_start)) {
                                          _rbookmark++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < _list[j].dishbookmark.length;
                                          i++) {
                                        if (_list[j]
                                                .dishbookmark[i]
                                                .isBefore(_end) &&
                                            _list[j]
                                                .dishbookmark[i]
                                                .isAfter(_start)) {
                                          _dbookmark++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < _list[j].share.length;
                                          i++) {
                                        if (_list[j].share[i].isBefore(_end) &&
                                            _list[j].share[i].isAfter(_start)) {
                                          _s++;
                                        }
                                      }
                                      for (int i = 0;
                                          i < _list[j].mapclick.length;
                                          i++) {
                                        if (_list[j]
                                                .mapclick[i]
                                                .isBefore(_end) &&
                                            _list[j]
                                                .mapclick[i]
                                                .isAfter(_start)) {
                                          _m++;
                                        }
                                      }
                                    }
                                  } else {
                                    final _i = _list.indexWhere(
                                      (element) =>
                                          element.name ==
                                          _namelist[indexsnap.data!],
                                    );
                                    for (int i = 0;
                                        i < _list[_i].restoview.length;
                                        i++) {
                                      if (_list[_i]
                                              .restoview[i]
                                              .isBefore(_end) &&
                                          _list[_i]
                                              .restoview[i]
                                              .isAfter(_start)) {
                                        _rview++;
                                      }
                                    }
                                    for (int i = 0;
                                        i < _list[_i].dishview.length;
                                        i++) {
                                      if (_list[_i]
                                              .dishview[i]
                                              .isBefore(_end) &&
                                          _list[_i]
                                              .dishview[i]
                                              .isAfter(_start)) {
                                        _dview++;
                                      }
                                    }
                                    for (int i = 0;
                                        i < _list[_i].restobookmark.length;
                                        i++) {
                                      if (_list[_i]
                                              .restobookmark[i]
                                              .isBefore(_end) &&
                                          _list[_i]
                                              .restobookmark[i]
                                              .isAfter(_start)) {
                                        _rbookmark++;
                                      }
                                    }
                                    for (int i = 0;
                                        i < _list[_i].dishbookmark.length;
                                        i++) {
                                      if (_list[_i]
                                              .dishbookmark[i]
                                              .isBefore(_end) &&
                                          _list[_i]
                                              .dishbookmark[i]
                                              .isAfter(_start)) {
                                        _dbookmark++;
                                      }
                                    }
                                    for (int i = 0;
                                        i < _list[_i].share.length;
                                        i++) {
                                      if (_list[_i].share[i].isBefore(_end) &&
                                          _list[_i].share[i].isAfter(_start)) {
                                        _s++;
                                      }
                                    }
                                    for (int i = 0;
                                        i < _list[_i].mapclick.length;
                                        i++) {
                                      if (_list[_i]
                                              .mapclick[i]
                                              .isBefore(_end) &&
                                          _list[_i]
                                              .mapclick[i]
                                              .isAfter(_start)) {
                                        _m++;
                                      }
                                    }
                                  }
                                } else {
                                  if (_namelist[indexsnap.data!] == "All") {
                                    _rview = _restoview;
                                    _dview = _dishview;
                                    _rbookmark = _restobookmark;
                                    _dbookmark = _dishbookmark;
                                    _s = _share;
                                    _m = _mapclick;
                                  } else {
                                    final _i = _list.indexWhere(
                                      (element) =>
                                          element.name ==
                                          _namelist[indexsnap.data!],
                                    );
                                    _rview = _list[_i].restoview.length;
                                    _dview = _list[_i].dishview.length;
                                    _rbookmark = _list[_i].restobookmark.length;
                                    _dbookmark = _list[_i].dishbookmark.length;
                                    _s = _list[_i].share.length;
                                    _m = _list[_i].mapclick.length;
                                  }
                                }
                              } else {
                                if (_namelist[indexsnap.data!] == "All") {
                                  _rview = _restoview;
                                  _dview = _dishview;
                                  _rbookmark = _restobookmark;
                                  _dbookmark = _dishbookmark;
                                  _s = _share;
                                  _m = _mapclick;
                                } else {
                                  final _i = _list.indexWhere(
                                    (element) =>
                                        element.name ==
                                        _namelist[indexsnap.data!],
                                  );
                                  _rview = _list[_i].restoview.length;
                                  _dview = _list[_i].dishview.length;
                                  _rbookmark = _list[_i].restobookmark.length;
                                  _dbookmark = _list[_i].dishbookmark.length;
                                  _s = _list[_i].share.length;
                                  _m = _list[_i].mapclick.length;
                                }
                              }

                              return SingleChildScrollView(
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
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03,
                                              vertical: 10,
                                            ),
                                            decoration: containerdeco,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  fromsnap.data == null
                                                      ? ""
                                                      : DateFormat("dd.MM.yyyy")
                                                          .format(
                                                              DateTime.parse(
                                                                  fromsnap
                                                                      .data!)),
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    color: txtcol,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final _date =
                                                        await pickthedate(
                                                            context);
                                                    if (_date != null) {
                                                      final String _dstring =
                                                          DateFormat("yyyyMMdd")
                                                              .format(_date);
                                                      _fromdate.sink
                                                          .add(_dstring);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .calendar_today_rounded,
                                                    color: txtcol,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03,
                                              vertical: 10,
                                            ),
                                            decoration: containerdeco,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  tosnap.data == null
                                                      ? ""
                                                      : DateFormat("dd.MM.yyyy")
                                                          .format(
                                                              DateTime.parse(
                                                                  tosnap
                                                                      .data!)),
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.05,
                                                    color: txtcol,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final _date =
                                                        await pickthedate(
                                                            context);
                                                    if (_date != null) {
                                                      final String _dstring =
                                                          DateFormat("yyyyMMdd")
                                                              .format(_date);
                                                      _todate.sink
                                                          .add(_dstring);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .calendar_today_rounded,
                                                    color: txtcol,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: selectrestostr,
                                      language: englishlangstr,
                                    ),
                                    CustomDropdownWidget(
                                      enable: widget.resto == "Super" ||
                                              widget.resto == "All Restaurants"
                                          ? true
                                          : false,
                                      size: size,
                                      hint: selectrestostr,
                                      mainvar: _namelist[indexsnap.data!],
                                      listofwidget: _namelist,
                                      onchange: (String? value) {
                                        if (value != null) {
                                          final _index = _namelist.indexWhere(
                                              (element) => element == value);
                                          _retoindex.sink.add(_index);
                                        }
                                      },
                                      language: englishlangstr,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: viewstr,
                                      language: englishlangstr,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    restaurantsstr,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _rview.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.05),
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    dishestr,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _dview.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: bookmarkstr,
                                      language: englishlangstr,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    restaurantsstr,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _rbookmark.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.05),
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    dishestr,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _dbookmark.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: sharestr,
                                      language: englishlangstr,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    restaurantsstr,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _s.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.05),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: mapclickstr,
                                      language: englishlangstr,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: containerdeco,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.04,
                                                vertical: 15,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    restaurantsstr,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.05,
                                                      color: txtcol,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    _m.toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.08,
                                                      color: greencol,
                                                      fontFamily:
                                                          secondaryfontfamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.05),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 100),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: nodatafound(),
                      );
                    }
                  },
                ),
                Positioned(
                  bottom: size.height * 0.015,
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: CustomTextfeild(
                            size: size,
                            hintstr: emailstr,
                            controller: _bloc.email,
                            lowmargin: true,
                            language: englishlangstr,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        SizedBox(
                          width: size.width * 0.3,
                          child: CustomButton(
                            size: size,
                            title: exportstr,
                            func: () {
                              _bloc.exportcsv();
                            },
                            removespace: true,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
