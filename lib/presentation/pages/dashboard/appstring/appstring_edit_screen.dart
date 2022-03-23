import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class AppStringEditScreen extends StatefulWidget {
  final int index;
  final AppString appstring;
  const AppStringEditScreen({
    Key? key,
    required this.index,
    required this.appstring,
  }) : super(key: key);

  @override
  State<AppStringEditScreen> createState() => _AppStringEditScreenState();
}

class _AppStringEditScreenState extends State<AppStringEditScreen> {
  final TextEditingController _engword = TextEditingController();
  final TextEditingController _areword = TextEditingController();
  final _loading = BoolStream();

  @override
  void initState() {
    _engword.text = widget.appstring.string[englishlangstr];
    _areword.text = widget.appstring.string[arabiclangstr];
    super.initState();
  }

  @override
  void dispose() {
    _engword.dispose();
    _areword.dispose();
    _loading.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomLable(
                    size: size,
                    title: "$englishlangstr String",
                    language: englishlangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: "$englishlangstr String",
                    controller: _engword,
                    language: englishlangstr,
                    enable: false,
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: "$arabiclangstr String",
                    language: arabiclangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: "$arabiclangstr String",
                    controller: _areword,
                    language: arabiclangstr,
                  ),
                  const SizedBox(height: 50),
                  StreamBuilder<bool>(
                    stream: _loading.stream,
                    initialData: false,
                    builder: (context, loadingsnap) {
                      if (loadingsnap.data!) {
                        return loadingwidget();
                      } else {
                        return CustomButton(
                          size: size,
                          title: "$updatestr $pagestr",
                          func: () {
                            _loading.sink.add(true);
                            if (_engword.text.isEmpty) {
                              snack(
                                "Alert !",
                                "Please Enter English Word !",
                                true,
                              );
                              _loading.sink.add(false);
                            } else if (_areword.text.isEmpty) {
                              snack(
                                "Alert !",
                                "Please Enter $arabiclangstr Word !",
                                true,
                              );
                              _loading.sink.add(false);
                            } else {
                              FirebaseHelper.changearbicstring(
                                widget.index,
                                _areword.text,
                              );
                              snack(
                                "Success",
                                "$arabiclangstr Word Changed.",
                                false,
                              );
                              _loading.sink.add(false);
                            }
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
