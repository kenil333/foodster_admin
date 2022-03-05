import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class CategoryEditScreen extends StatefulWidget {
  final List<TagModel> tagslist;
  final CategoryModel category;
  const CategoryEditScreen({
    Key? key,
    required this.tagslist,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryEditScreen> createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  final _bloc = CategoryEditBloc();
  final _language = StringStream();
  final _display = StringStream();
  final _listoftags = ListStringStream();
  final _image = FileStream();
  final _delload = BoolStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.category.number,
      widget.category.name[englishlangstr]!,
      widget.category.name[arabiclangstr]!,
      widget.category.tags,
      widget.category.displaytype,
    );
    super.initState();
  }

  @override
  void dispose() {
    _language.dispose();
    _display.dispose();
    _listoftags.dispose();
    _image.dispose();
    _bloc.loading.dispose();
    _bloc.namearabic.dispose();
    _bloc.nameenglish.dispose();
    _bloc.numbercontrol.dispose();
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
                        controller: snap.data == englishlangstr
                            ? _bloc.nameenglish
                            : _bloc.namearabic,
                        language: snap.data!,
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: imagestr,
                        // "$imagestr ${((widget.category.count) % 2) == 0 ? "(Right)" : "(Left)"}",
                        language: snap.data!,
                      ),
                      StreamBuilder<File?>(
                        stream: _image.stream,
                        initialData: null,
                        builder: (context, imagesnap) {
                          return Container(
                            width: double.infinity,
                            height: size.height * 0.15,
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 0,
                            ),
                            decoration: containerdeco,
                            child: imagesnap.data == null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CustomNetworkImage(
                                            image: widget.category.image!,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: InkWell(
                                          onTap: () async {
                                            File? _imagefile =
                                                await chooseimage();
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
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 10),
                                                  blurRadius: 20,
                                                  color:
                                                      txtcol.withOpacity(0.23),
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
                                : Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            File? _imagefile =
                                                await chooseimage();
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
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 10),
                                                  blurRadius: 20,
                                                  color:
                                                      txtcol.withOpacity(0.23),
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
                                  ),
                          );
                        },
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
                        child: StreamBuilder<List<String>>(
                          stream: _listoftags.stream,
                          initialData: widget.category.tags,
                          builder: (context, tagsnap) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: size.width * 0.03,
                                mainAxisSpacing: size.width * 0.03,
                                childAspectRatio: 2 / 0.4,
                              ),
                              itemCount: widget.tagslist.length,
                              itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  List<String> _list = [];
                                  _list.addAll(tagsnap.data!);
                                  if (tagsnap.data!
                                      .contains(widget.tagslist[i].id)) {
                                    _list.remove(widget.tagslist[i].id);
                                  } else {
                                    _list.add(widget.tagslist[i].id);
                                  }
                                  _bloc.taglist = _list;
                                  _listoftags.sink.add(_list);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      tagsnap.data!
                                              .contains(widget.tagslist[i].id)
                                          ? checksvg
                                          : unchecksvg,
                                      width: size.width * 0.065,
                                      color: txtcol,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        widget.tagslist[i].name[snap.data]!,
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: displaytypestr,
                        language: snap.data!,
                      ),
                      StreamBuilder<String?>(
                        stream: _display.stream,
                        initialData: widget.category.displaytype,
                        builder: (context, displaysnap) {
                          return CustomDropdownWidget(
                            size: size,
                            hint: displaytypestr,
                            mainvar: displaysnap.data,
                            listofwidget: const [restaurantsstr, dishestr],
                            onchange: (String? value) {
                              _bloc.displaytype = value;
                              _display.sink.add(value);
                            },
                            language: snap.data!,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: "Count",
                        language: snap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: "Count",
                        controller: _bloc.numbercontrol,
                        language: snap.data!,
                        number: true,
                        numberonly: true,
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
                              title: "$updatestr $categoriestr",
                              func: () {
                                _bloc.editcategory(widget.category.id);
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
                              title: "$deletestr $categoriestr",
                              func: () async {
                                _delload.sink.add(true);
                                await FirebaseHelper.deletecategoryfire(
                                  widget.category.id,
                                  widget.category.image!,
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
