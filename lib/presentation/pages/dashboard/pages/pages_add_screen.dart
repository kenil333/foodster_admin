import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class PageAddScreen extends StatefulWidget {
  const PageAddScreen({Key? key}) : super(key: key);

  @override
  _PageAddScreenState createState() => _PageAddScreenState();
}

class _PageAddScreenState extends State<PageAddScreen> {
  final _bloc = PageAddBloc();
  final _language = StringStream();

  @override
  void dispose() {
    _language.dispose();
    _bloc.loading.dispose();
    _bloc.titleenglish.dispose();
    _bloc.titlearabic.dispose();
    _bloc.contentenglish.dispose();
    _bloc.contentarabic.dispose();
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
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: titlestr,
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: titlestr,
                        controller: snap.data! == englishlangstr
                            ? _bloc.titleenglish
                            : _bloc.titlearabic,
                        language: snap.data!,
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: contentstr,
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: contentstr,
                        controller: snap.data! == englishlangstr
                            ? _bloc.contentenglish
                            : _bloc.contentarabic,
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
                              title: "$addstr $pagestr",
                              func: () {
                                _bloc.addpage();
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
