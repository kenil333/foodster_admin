import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class ResturantAddScreen extends StatefulWidget {
  const ResturantAddScreen({Key? key}) : super(key: key);

  @override
  State<ResturantAddScreen> createState() => _ResturantAddScreenState();
}

class _ResturantAddScreenState extends State<ResturantAddScreen> {
  final _bloc = RestaurantAddBloc();
  final _language = StringStream();
  final _listoftags = ListStringStream();
  final _profile = ListFileStream();
  final _resto = ListFileStream();
  final _tags = ListTagStream();
  final _tagload = BoolStream();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      await FirebaseHelper.getlistoftags(
        (List<TagModel> listof) {
          _tags.sink.add(listof);
          _tagload.sink.add(false);
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _language.dispose();
    _bloc.nameenglish.dispose();
    _bloc.typeenglish.dispose();
    _bloc.latitudecont.dispose();
    _bloc.longitudecont.dispose();
    _bloc.timmingenglish.dispose();
    _bloc.descriptionenglish.dispose();
    _bloc.locationenglish.dispose();
    _bloc.namearabic.dispose();
    _bloc.typearabic.dispose();
    _bloc.timmingarabic.dispose();
    _bloc.descriptionarabic.dispose();
    _bloc.locationarabic.dispose();
    _bloc.loading.dispose();
    _bloc.numbercontroller.dispose();
    _listoftags.dispose();
    _profile.dispose();
    _resto.dispose();
    _tags.dispose();
    _tagload.dispose();
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
                  StreamBuilder<bool>(
                    stream: _tagload.stream,
                    initialData: true,
                    builder: (context, tagloadsnap) {
                      if (tagloadsnap.data!) {
                        return loadingwidget();
                      } else {
                        return StreamBuilder<List<TagModel>>(
                          stream: _tags.stream,
                          initialData: const [],
                          builder: (context, taglistsnap) =>
                              StreamBuilder<List<String>>(
                            stream: _listoftags.stream,
                            initialData: const [],
                            builder: (context, tagsnap) =>
                                StreamBuilder<String?>(
                              stream: _language.stream,
                              initialData: englishlangstr,
                              builder: (context, snap) {
                                return Column(
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
                                      controller: snap.data == englishlangstr
                                          ? _bloc.nameenglish
                                          : _bloc.namearabic,
                                      language: snap.data!,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: typestr,
                                      language: snap.data!,
                                    ),
                                    CustomTextfeild(
                                      size: size,
                                      hintstr: typestr,
                                      controller: snap.data == englishlangstr
                                          ? _bloc.typeenglish
                                          : _bloc.typearabic,
                                      language: snap.data!,
                                    ),
                                    const SizedBox(height: 15),
                                    snap.data! == englishlangstr
                                        ? CustomLable(
                                            size: size,
                                            title: latitudestr,
                                            language: snap.data!,
                                          )
                                        : Container(),
                                    snap.data! == englishlangstr
                                        ? CustomTextfeild(
                                            size: size,
                                            hintstr: latitudestr,
                                            controller: _bloc.latitudecont,
                                            language: snap.data!,
                                            number: true,
                                            doublevalue: true,
                                          )
                                        : Container(),
                                    const SizedBox(height: 15),
                                    snap.data! == englishlangstr
                                        ? CustomLable(
                                            size: size,
                                            title: longitudestr,
                                            language: snap.data!,
                                          )
                                        : Container(),
                                    snap.data! == englishlangstr
                                        ? CustomTextfeild(
                                            size: size,
                                            hintstr: longitudestr,
                                            controller: _bloc.longitudecont,
                                            language: snap.data!,
                                            number: true,
                                            doublevalue: true,
                                          )
                                        : Container(),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: timmingstr,
                                      language: snap.data!,
                                    ),
                                    CustomTextfeild(
                                      size: size,
                                      hintstr: timmingstr,
                                      controller: snap.data == englishlangstr
                                          ? _bloc.timmingenglish
                                          : _bloc.timmingarabic,
                                      maxline: true,
                                      language: snap.data!,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: descriptionstr,
                                      language: snap.data!,
                                    ),
                                    CustomTextfeild(
                                      size: size,
                                      hintstr: descriptionstr,
                                      controller: snap.data == englishlangstr
                                          ? _bloc.descriptionenglish
                                          : _bloc.descriptionarabic,
                                      maxline: true,
                                      language: snap.data!,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: locationstr,
                                      language: snap.data!,
                                    ),
                                    CustomTextfeild(
                                      size: size,
                                      hintstr: locationstr,
                                      controller: snap.data == englishlangstr
                                          ? _bloc.locationenglish
                                          : _bloc.locationarabic,
                                      language: snap.data!,
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: selecttagstr,
                                      language: snap.data!,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: size.width * 0.04,
                                      ),
                                      decoration: containerdeco,
                                      child: taglistsnap.data!.isNotEmpty
                                          ? GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing:
                                                    size.width * 0.03,
                                                mainAxisSpacing:
                                                    size.width * 0.03,
                                                childAspectRatio: 2 / 0.4,
                                              ),
                                              itemCount:
                                                  taglistsnap.data!.length,
                                              itemBuilder: (context, i) =>
                                                  InkWell(
                                                onTap: () {
                                                  List<String> _listoft = [];
                                                  _listoft
                                                      .addAll(tagsnap.data!);
                                                  if (_listoft.contains(
                                                      taglistsnap
                                                          .data![i].id)) {
                                                    _listoft.remove(taglistsnap
                                                        .data![i].id);
                                                  } else {
                                                    _listoft.add(taglistsnap
                                                        .data![i].id);
                                                  }
                                                  _bloc.tags = _listoft;
                                                  _listoftags.sink
                                                      .add(_listoft);
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      tagsnap.data!.contains(
                                                              taglistsnap
                                                                  .data![i].id)
                                                          ? checksvg
                                                          : unchecksvg,
                                                      width: size.width * 0.065,
                                                      color: txtcol,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Expanded(
                                                      child: Text(
                                                        taglistsnap.data![i]
                                                            .name[snap.data]!,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          color: txtcol,
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Text(
                                              "Please Add Tags First then Insert Resturant.",
                                              style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                color: primarycol,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: addprofilephotostr,
                                      language: snap.data!,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: size.width * 0.04,
                                      ),
                                      decoration: containerdeco,
                                      child: StreamBuilder<List<File>>(
                                        stream: _profile.stream,
                                        initialData: const [],
                                        builder: (context, profilepicsnap) {
                                          if (profilepicsnap.data!.isEmpty) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Please Select the Image.",
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                      color: primarycol,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.03),
                                                InkWell(
                                                  onTap: () async {
                                                    File? _image =
                                                        await chooseimage();
                                                    if (_image != null) {
                                                      _bloc.profilepic
                                                          .add(_image);
                                                      _profile.sink
                                                          .add([_image]);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    size: size.width * 0.12,
                                                    color: greencol,
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing:
                                                          size.width * 0.03,
                                                      mainAxisSpacing:
                                                          size.width * 0.03,
                                                      childAspectRatio: 2 / 2,
                                                    ),
                                                    itemCount: profilepicsnap
                                                        .data!.length,
                                                    itemBuilder: (context, i) =>
                                                        InkWell(
                                                      onLongPress: () {
                                                        showremovedilog(
                                                          size,
                                                          context,
                                                          () {
                                                            List<File> _pics =
                                                                [];
                                                            _pics =
                                                                profilepicsnap
                                                                    .data!;
                                                            _pics.removeAt(i);
                                                            _bloc.profilepic =
                                                                _pics;
                                                            _profile.sink
                                                                .add(_pics);
                                                          },
                                                        );
                                                      },
                                                      child: Image.file(
                                                        profilepicsnap.data![i],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.03),
                                                InkWell(
                                                  onTap: () async {
                                                    File? _image =
                                                        await chooseimage();
                                                    if (_image != null) {
                                                      List<File> _pics = [];
                                                      _pics =
                                                          profilepicsnap.data!;
                                                      _pics.add(_image);
                                                      _bloc.profilepic = _pics;
                                                      _profile.sink.add(_pics);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    size: size.width * 0.12,
                                                    color: greencol,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    CustomLable(
                                      size: size,
                                      title: addrestaurantphotostr,
                                      language: snap.data!,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: size.width * 0.04,
                                      ),
                                      decoration: containerdeco,
                                      child: StreamBuilder<List<File>>(
                                        stream: _resto.stream,
                                        initialData: const [],
                                        builder: (context, restopicsnap) {
                                          if (restopicsnap.data!.isEmpty) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Please Select the Image.",
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                      color: primarycol,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.03),
                                                InkWell(
                                                  onTap: () async {
                                                    File? _image =
                                                        await chooseimage();
                                                    if (_image != null) {
                                                      _bloc.restopic
                                                          .add(_image);
                                                      _resto.sink.add([_image]);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    size: size.width * 0.12,
                                                    color: greencol,
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing:
                                                          size.width * 0.03,
                                                      mainAxisSpacing:
                                                          size.width * 0.03,
                                                      childAspectRatio: 2 / 2,
                                                    ),
                                                    itemCount: restopicsnap
                                                        .data!.length,
                                                    itemBuilder: (context, i) =>
                                                        InkWell(
                                                      onLongPress: () {
                                                        showremovedilog(
                                                          size,
                                                          context,
                                                          () {
                                                            List<File> _pics =
                                                                [];
                                                            _pics = restopicsnap
                                                                .data!;
                                                            _pics.removeAt(i);
                                                            _bloc.restopic =
                                                                _pics;
                                                            _resto.sink
                                                                .add(_pics);
                                                          },
                                                        );
                                                      },
                                                      child: Image.file(
                                                        restopicsnap.data![i],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.03),
                                                InkWell(
                                                  onTap: () async {
                                                    File? _image =
                                                        await chooseimage();
                                                    if (_image != null) {
                                                      List<File> _pics = [];
                                                      _pics =
                                                          restopicsnap.data!;
                                                      _pics.add(_image);
                                                      _bloc.restopic = _pics;
                                                      _resto.sink.add(_pics);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle,
                                                    size: size.width * 0.12,
                                                    color: greencol,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    snap.data! == englishlangstr
                                        ? CustomLable(
                                            size: size,
                                            title: "Count",
                                            language: snap.data!,
                                          )
                                        : Container(),
                                    snap.data! == englishlangstr
                                        ? CustomTextfeild(
                                            size: size,
                                            hintstr: "Count",
                                            controller: _bloc.numbercontroller,
                                            language: snap.data!,
                                            number: true,
                                            numberonly: true,
                                          )
                                        : Container(),
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
                                            title: "$addstr $restaurantsstr",
                                            func: () {
                                              _bloc.addresturant();
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
