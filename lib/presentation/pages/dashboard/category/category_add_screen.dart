import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class CategoryAddScreen extends StatefulWidget {
  final List<TagModel> tags;
  final int restolenfth;
  final int dishlength;
  const CategoryAddScreen({
    Key? key,
    required this.tags,
    required this.restolenfth,
    required this.dishlength,
  }) : super(key: key);

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  final _bloc = CategoryAddBloc();
  final _language = StringStream();
  final _display = StringStream();
  final _listoftags = ListStringStream();
  final _image = FileStream();

  @override
  void initState() {
    _bloc.restol = widget.restolenfth;
    _bloc.dushl = widget.dishlength;
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
    _bloc.numbercontroll.dispose();
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
              builder: (context, langsnap) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: selectlanguagestr,
                        language: langsnap.data!,
                      ),
                      CustomDropdownWidget(
                        size: size,
                        hint: selectlanguagestr,
                        mainvar: langsnap.data,
                        listofwidget: const [
                          englishlangstr,
                          arabiclangstr,
                        ],
                        onchange: (String? value) {
                          _language.sink.add(value);
                        },
                        language: langsnap.data!,
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: namestr,
                        language: langsnap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: namestr,
                        controller: langsnap.data == englishlangstr
                            ? _bloc.nameenglish
                            : _bloc.namearabic,
                        language: langsnap.data!,
                      ),
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: imagestr, // "$imagestr (${_bloc.sidestr})",
                        language: langsnap.data!,
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
                            child: imagesnap.data != null
                                ? Stack(
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
                      const SizedBox(height: 15),
                      CustomLable(
                        size: size,
                        title: selecttagstr,
                        language: langsnap.data!,
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
                        child: widget.tags.isNotEmpty
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
                                    itemCount: widget.tags.length,
                                    itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        List<String> _list = [];
                                        _list.addAll(tagsnap.data!);
                                        if (_list.contains(widget.tags[i].id)) {
                                          _list.remove(widget.tags[i].id);
                                        } else {
                                          _list.add(widget.tags[i].id);
                                        }
                                        _bloc.taglist = _list;
                                        _listoftags.sink.add(_list);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            tagsnap.data!
                                                    .contains(widget.tags[i].id)
                                                ? checksvg
                                                : unchecksvg,
                                            width: size.width * 0.065,
                                            color: txtcol,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.tags[i]
                                                  .name[langsnap.data!]!,
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
                                "Please Add Tags First then Insert Category.",
                                style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  color: primarycol,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: displaytypestr,
                        language: langsnap.data!,
                      ),
                      StreamBuilder<String?>(
                        stream: _display.stream,
                        initialData: null,
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
                            language: langsnap.data!,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomLable(
                        size: size,
                        title: "Count",
                        language: langsnap.data!,
                      ),
                      CustomTextfeild(
                        size: size,
                        hintstr: "Count",
                        controller: _bloc.numbercontroll,
                        language: langsnap.data!,
                        number: true,
                        numberonly: true,
                      ),
                      const SizedBox(height: 50),
                      widget.tags.isNotEmpty
                          ? StreamBuilder<bool>(
                              stream: _bloc.loading.stream,
                              initialData: false,
                              builder: (context, loadingsnap) {
                                if (loadingsnap.data!) {
                                  return loadingwidget();
                                } else {
                                  return CustomButton(
                                    size: size,
                                    title: "$addstr $categoriestr",
                                    func: () {
                                      _bloc.addcategory();
                                    },
                                  );
                                }
                              },
                            )
                          : Container(),
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
