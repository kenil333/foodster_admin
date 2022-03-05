import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class TagEditScreen extends StatefulWidget {
  final TagModel tag;
  const TagEditScreen({Key? key, required this.tag}) : super(key: key);

  @override
  _TagEditScreenState createState() => _TagEditScreenState();
}

class _TagEditScreenState extends State<TagEditScreen> {
  final _language = StringStream();
  final _bloc = TagEditBloc();
  final _delload = BoolStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.tag.name[englishlangstr]!,
      widget.tag.name[arabiclangstr]!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _language.dispose();
    _bloc.loading.dispose();
    _bloc.namearabic.dispose();
    _bloc.nameenglish.dispose();
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
                        title: namestr,
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: namestr,
                        controller: snap.data! == englishlangstr
                            ? _bloc.nameenglish
                            : _bloc.namearabic,
                        language: snap.data!,
                      ),
                      const SizedBox(height: 50),
                      StreamBuilder<bool>(
                        stream: _bloc.loading.stream,
                        initialData: false,
                        builder: (context, loadingsnap) {
                          return CustomButton(
                            size: size,
                            title: "$updatestr $tagstr",
                            func: () {
                              _bloc.edittag(widget.tag.id);
                            },
                          );
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
                              title: "$deletestr $tagstr",
                              func: () async {
                                _delload.sink.add(true);
                                await FirebaseHelper.deletetagfire(
                                  widget.tag.id,
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
