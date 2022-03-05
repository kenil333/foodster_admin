import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class PageEditScreen extends StatefulWidget {
  final PageModel page;
  const PageEditScreen({Key? key, required this.page}) : super(key: key);

  @override
  _PageEditScreenState createState() => _PageEditScreenState();
}

class _PageEditScreenState extends State<PageEditScreen> {
  final _bloc = PageEditBloc();
  final _language = StringStream();
  final _delload = BoolStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.page.title[englishlangstr]!,
      widget.page.title[arabiclangstr]!,
      widget.page.content[englishlangstr]!,
      widget.page.content[arabiclangstr]!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _language.dispose();
    _bloc.loading.dispose();
    _delload.dispose();
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
                              title: "$updatestr $pagestr",
                              func: () {
                                _bloc.editpage(widget.page.id);
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<bool>(
                        stream: _delload.stream,
                        initialData: false,
                        builder: (context, loadingsnap) {
                          if (loadingsnap.data!) {
                            return loadingwidget();
                          } else {
                            return CustomButton(
                              size: size,
                              title: "$deletestr $pagestr",
                              func: () async {
                                _delload.sink.add(true);
                                await FirebaseHelper.deletepagefire(
                                  widget.page.id,
                                );
                                _delload.sink.add(false);
                                Navigator.of(context).pop();
                              },
                              color: redcolor,
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
