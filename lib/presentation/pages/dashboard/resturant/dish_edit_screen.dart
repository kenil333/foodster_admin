import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class DishUpdateScreen extends StatefulWidget {
  final List<TagModel> taglist;
  final DishModel dish;
  const DishUpdateScreen({
    Key? key,
    required this.taglist,
    required this.dish,
  }) : super(key: key);

  @override
  _DishUpdateScreenState createState() => _DishUpdateScreenState();
}

class _DishUpdateScreenState extends State<DishUpdateScreen> {
  final _bloc = DishEditBloc();
  final _language = StringStream();
  final _listoftags = ListStringStream();
  final _pics = ListFileStream();
  final _picsurl = ListStringStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.dish.name[englishlangstr],
      widget.dish.name[arabiclangstr],
      widget.dish.description[englishlangstr],
      widget.dish.description[arabiclangstr],
      widget.dish.price.toStringAsFixed(1),
      widget.dish.tags,
      widget.dish.images,
    );
    super.initState();
  }

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
    _picsurl.dispose();
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
                        language: englishlangstr,
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
                              language: englishlangstr,
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
                        language: englishlangstr,
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
                                initialData: widget.dish.tags,
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
                        child: StreamBuilder<List<String>>(
                          stream: _picsurl.stream,
                          initialData: widget.dish.images,
                          builder: (context, urlsnap) =>
                              StreamBuilder<List<File>>(
                            stream: _pics.stream,
                            initialData: const [],
                            builder: (context, picsnap) {
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
                                      itemCount: picsnap.data!.isEmpty
                                          ? urlsnap.data!.length
                                          : urlsnap.data!.length +
                                              picsnap.data!.length,
                                      itemBuilder: (context, i) => i >
                                              urlsnap.data!.length - 1
                                          ? InkWell(
                                              onLongPress: () {
                                                showremovedilog(
                                                  size,
                                                  context,
                                                  () {
                                                    List<File> _p = [];
                                                    _p = picsnap.data!;
                                                    _p.removeAt(i -
                                                        urlsnap.data!.length);
                                                    _bloc.photos = _p;
                                                    _pics.sink.add(_p);
                                                  },
                                                );
                                              },
                                              child: Image.file(
                                                picsnap.data![
                                                    i - urlsnap.data!.length],
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : InkWell(
                                              onLongPress: () {
                                                showremovedilog(
                                                  size,
                                                  context,
                                                  () async {
                                                    if (urlsnap.data!.length >
                                                        1) {
                                                      List<String> _z = [];
                                                      _z = urlsnap.data!;
                                                      await FirebaseHelper
                                                          .removeimagefromurl(
                                                        _z[i],
                                                      );
                                                      _z.removeAt(i);
                                                      await FirebaseHelper
                                                          .dishimaheurl(
                                                        widget.dish.id,
                                                        _z,
                                                      );
                                                      _bloc.urlstr = _z;
                                                      _picsurl.sink.add(_z);
                                                    } else {
                                                      snack(
                                                        "Alert !",
                                                        "You have to take 1 Image in !",
                                                        true,
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                              child: CustomNetworkImage(
                                                image: urlsnap.data![i],
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  InkWell(
                                    onTap: () async {
                                      File? _image = await chooseimage();
                                      if (_image != null) {
                                        if (picsnap.data!.isEmpty) {
                                          _bloc.photos.add(_image);
                                          _pics.sink.add([_image]);
                                        } else {
                                          List<File> _picsima = [];
                                          _picsima = picsnap.data!;
                                          _picsima.add(_image);
                                          _bloc.photos = _picsima;
                                          _pics.sink.add(_picsima);
                                        }
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
                            },
                          ),
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
                              title: updatdishstr,
                              func: () {
                                _bloc.editdishe(
                                  widget.dish.id,
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      StreamBuilder<bool>(
                        stream: _bloc.delloading.stream,
                        initialData: false,
                        builder: (context, delloadingsnap) {
                          if (delloadingsnap.data!) {
                            return loadingwidget();
                          } else {
                            return CustomButton(
                              size: size,
                              title: "$deletestr $dishestr",
                              func: () {
                                _bloc.deletedish(
                                  widget.dish.id,
                                );
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
