import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class DishAddScreen extends StatefulWidget {
  final List<TagModel> taglist;
  final String restoid;
  const DishAddScreen({
    Key? key,
    required this.taglist,
    required this.restoid,
  }) : super(key: key);

  @override
  _DishAddScreenState createState() => _DishAddScreenState();
}

class _DishAddScreenState extends State<DishAddScreen> {
  final _bloc = DishAddBloc();
  final _language = StringStream();
  final _listoftags = ListStringStream();
  final _pics = ListFileStream();

  @override
  void dispose() {
    _language.dispose();
    _bloc.nameenglish.dispose();
    _bloc.namearabic.dispose();
    _bloc.descriptionenglish.dispose();
    _bloc.descriptionarabic.dispose();
    _bloc.price.dispose();
    _bloc.loading.dispose();
    _listoftags.dispose();
    _pics.dispose();
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
                        controller: snap.data == englishlangstr
                            ? _bloc.nameenglish
                            : _bloc.namearabic,
                        language: snap.data!,
                      ),
                      const SizedBox(height: 15),
                      snap.data! == englishlangstr
                          ? CustomLable(
                              size: size,
                              title: pricestr,
                              language: snap.data!,
                            )
                          : Container(),
                      snap.data! == englishlangstr
                          ? CustomTextfeild(
                              size: size,
                              hintstr: pricestr,
                              controller: _bloc.price,
                              language: snap.data!,
                              number: true,
                            )
                          : Container(),
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
                        child: widget.taglist.isNotEmpty
                            ? StreamBuilder<List<String>>(
                                stream: _listoftags.stream,
                                initialData: const [],
                                builder: (context, tagsnap) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: size.width * 0.03,
                                      mainAxisSpacing: size.width * 0.03,
                                      childAspectRatio: 2 / 0.4,
                                    ),
                                    itemCount: widget.taglist.length,
                                    itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        List<String> _listoft = [];
                                        _listoft.addAll(tagsnap.data!);
                                        if (_listoft
                                            .contains(widget.taglist[i].id)) {
                                          _listoft.remove(widget.taglist[i].id);
                                        } else {
                                          _listoft.add(widget.taglist[i].id);
                                        }
                                        _bloc.tags = _listoft;
                                        _listoftags.sink.add(_listoft);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            tagsnap.data!.contains(
                                                    widget.taglist[i].id)
                                                ? checksvg
                                                : unchecksvg,
                                            width: size.width * 0.065,
                                            color: txtcol,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget
                                                  .taglist[i].name[snap.data]!,
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                color: txtcol,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Text(
                                "Please Add Tags First then Insert Dish.",
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
                        title: addishphotostr,
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
                          stream: _pics.stream,
                          initialData: const [],
                          builder: (context, picsnap) {
                            if (picsnap.data!.isEmpty) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Please Select the Image.",
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        color: primarycol,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  InkWell(
                                    onTap: () async {
                                      File? _image = await chooseimage();
                                      if (_image != null) {
                                        _bloc.photos.add(_image);
                                        _pics.sink.add([_image]);
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
                                        crossAxisSpacing: size.width * 0.03,
                                        mainAxisSpacing: size.width * 0.03,
                                        childAspectRatio: 2 / 2,
                                      ),
                                      itemCount: picsnap.data!.length,
                                      itemBuilder: (context, i) => InkWell(
                                        onLongPress: () {
                                          showremovedilog(
                                            size,
                                            context,
                                            () {
                                              List<File> _p = [];
                                              _p = picsnap.data!;
                                              _p.removeAt(i);
                                              _bloc.photos = _p;
                                              _pics.sink.add(_p);
                                            },
                                          );
                                        },
                                        child: Image.file(
                                          picsnap.data![i],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  InkWell(
                                    onTap: () async {
                                      File? _image = await chooseimage();
                                      if (_image != null) {
                                        List<File> _picima = [];
                                        _picima = picsnap.data!;
                                        _picima.add(_image);
                                        _bloc.photos = _picima;
                                        _pics.sink.add(_picima);
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
                              title: adddishestr,
                              func: () {
                                _bloc.adddishe(widget.restoid);
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
