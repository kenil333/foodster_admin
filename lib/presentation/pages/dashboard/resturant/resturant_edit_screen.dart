import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../../domain/all.dart';

class RestuarantEditScreen extends StatefulWidget {
  final ResturantModel resturant;
  const RestuarantEditScreen({
    Key? key,
    required this.resturant,
  }) : super(key: key);

  @override
  _RestuarantEditScreenState createState() => _RestuarantEditScreenState();
}

class _RestuarantEditScreenState extends State<RestuarantEditScreen> {
  final _bloc = ResturantEditBloc();
  final _language = StringStream();
  final _listoftags = ListStringStream();
  final _profile = ListFileStream();
  final _resto = ListFileStream();
  final _display = StringStream();
  final _tags = ListTagStream();
  final _tagload = BoolStream();
  final _profileurls = ListStringStream();
  final _restourls = ListStringStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.resturant.number,
      widget.resturant.name[englishlangstr],
      widget.resturant.name[arabiclangstr],
      widget.resturant.type[englishlangstr],
      widget.resturant.type[arabiclangstr],
      widget.resturant.latitude,
      widget.resturant.longitude,
      widget.resturant.timming[englishlangstr],
      widget.resturant.timming[arabiclangstr],
      widget.resturant.description[englishlangstr],
      widget.resturant.description[arabiclangstr],
      widget.resturant.location[englishlangstr],
      widget.resturant.location[arabiclangstr],
      widget.resturant.tags,
      widget.resturant.display,
      widget.resturant.profilepic,
      widget.resturant.restopic,
    );
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
    _bloc.latitude.dispose();
    _bloc.longitude.dispose();
    _bloc.timmingenglish.dispose();
    _bloc.descriptionenglish.dispose();
    _bloc.namearabic.dispose();
    _bloc.typearabic.dispose();
    _bloc.timmingarabic.dispose();
    _bloc.descriptionarabic.dispose();
    _bloc.locationenglish.dispose();
    _bloc.locationarabic.dispose();
    _bloc.loading.dispose();
    _bloc.numbercontroller.dispose();
    _listoftags.dispose();
    _profile.dispose();
    _resto.dispose();
    _tags.dispose();
    _tagload.dispose();
    _restourls.dispose();
    _profileurls.dispose();
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
            child: StreamBuilder<bool>(
              stream: _tagload.stream,
              initialData: true,
              builder: (context, tagloadsnap) {
                if (tagloadsnap.data!) {
                  return loadingwidget();
                } else {
                  return StreamBuilder<List<TagModel>>(
                    stream: _tags.stream,
                    initialData: const [],
                    builder: (context, taglistsnap) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
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
                                            controller: _bloc.latitude,
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
                                            controller: _bloc.longitude,
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
                                          ? StreamBuilder<List<String>>(
                                              stream: _listoftags.stream,
                                              initialData:
                                                  widget.resturant.tags,
                                              builder: (context, tagsnap) {
                                                return GridView.builder(
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
                                                      List<String> _listoft =
                                                          [];
                                                      _listoft.addAll(
                                                          tagsnap.data!);
                                                      if (_listoft.contains(
                                                          taglistsnap
                                                              .data![i].id)) {
                                                        _listoft.remove(
                                                            taglistsnap
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
                                                                      .data![i]
                                                                      .id)
                                                              ? checksvg
                                                              : unchecksvg,
                                                          width: size.width *
                                                              0.065,
                                                          color: txtcol,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Expanded(
                                                          child: Text(
                                                            taglistsnap.data![i]
                                                                    .name[
                                                                snap.data]!,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              color: txtcol,
                                                              fontSize:
                                                                  size.width *
                                                                      0.04,
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
                                              "Please Add Tags First then Insert Resturant.",
                                              style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                color: primarycol,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                );
                              },
                            ),
                            CustomLable(
                              size: size,
                              title: addprofilephotostr,
                              language: englishlangstr,
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
                                stream: _profileurls.stream,
                                initialData: widget.resturant.profilepic,
                                builder: (context, profileurlsnap) =>
                                    StreamBuilder<List<File>>(
                                  stream: _profile.stream,
                                  initialData: const [],
                                  builder: (context, profilepicsnap) {
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
                                                    .data!.isEmpty
                                                ? profileurlsnap.data!.length
                                                : profileurlsnap.data!.length +
                                                    profilepicsnap.data!.length,
                                            itemBuilder: (context, i) => i >
                                                    profileurlsnap
                                                            .data!.length -
                                                        1
                                                ? InkWell(
                                                    onLongPress: () {
                                                      showremovedilog(
                                                        size,
                                                        context,
                                                        () {
                                                          List<File> _p = [];
                                                          _p = profilepicsnap
                                                              .data!;
                                                          _p.removeAt(i -
                                                              widget
                                                                  .resturant
                                                                  .profilepic
                                                                  .length);
                                                          _bloc.profilepic = _p;
                                                          _profile.sink.add(
                                                            _p,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Image.file(
                                                      profilepicsnap.data![i -
                                                          widget
                                                              .resturant
                                                              .profilepic
                                                              .length],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : InkWell(
                                                    onLongPress: () {
                                                      showremovedilog(
                                                        size,
                                                        context,
                                                        () async {
                                                          if (profileurlsnap
                                                                  .data!
                                                                  .length >
                                                              1) {
                                                            List<String> _z =
                                                                [];
                                                            _z = profileurlsnap
                                                                .data!;
                                                            await FirebaseHelper
                                                                .removeimagefromurl(
                                                              _z[i],
                                                            );
                                                            _z.removeAt(i);
                                                            await FirebaseHelper
                                                                .restoimgeurl(
                                                              widget
                                                                  .resturant.id,
                                                              _z,
                                                              true,
                                                            );
                                                            _bloc.profileurl =
                                                                _z;
                                                            _profileurls.sink
                                                                .add(_z);
                                                          } else {
                                                            snack(
                                                              "Alert !",
                                                              "You have to take 1 image in !",
                                                              true,
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: CustomNetworkImage(
                                                      image: profileurlsnap
                                                          .data![i],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        InkWell(
                                          onTap: () async {
                                            File? _image = await chooseimage();
                                            if (_image != null) {
                                              if (profilepicsnap
                                                  .data!.isEmpty) {
                                                _bloc.profilepic.add(_image);
                                                _profile.sink.add([_image]);
                                              } else {
                                                List<File> _pics = [];
                                                _pics = profilepicsnap.data!;
                                                _pics.add(_image);
                                                _bloc.profilepic = _pics;
                                                _profile.sink.add(_pics);
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
                            const SizedBox(height: 15),
                            CustomLable(
                              size: size,
                              title: addrestaurantphotostr,
                              language: englishlangstr,
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
                                stream: _restourls.stream,
                                initialData: widget.resturant.restopic,
                                builder: (context, restourlsnap) =>
                                    StreamBuilder<List<File>>(
                                  stream: _resto.stream,
                                  initialData: const [],
                                  builder: (context, restopicsnap) {
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
                                                    .data!.isEmpty
                                                ? restourlsnap.data!.length
                                                : restourlsnap.data!.length +
                                                    restopicsnap.data!.length,
                                            itemBuilder: (context, i) => i >
                                                    restourlsnap.data!.length -
                                                        1
                                                ? InkWell(
                                                    onLongPress: () {
                                                      showremovedilog(
                                                        size,
                                                        context,
                                                        () {
                                                          List<File> _p = [];
                                                          _p = restopicsnap
                                                              .data!;
                                                          _p.removeAt(i -
                                                              widget
                                                                  .resturant
                                                                  .restopic
                                                                  .length);
                                                          _bloc.restopic = _p;
                                                          _resto.sink.add(_p);
                                                        },
                                                      );
                                                    },
                                                    child: Image.file(
                                                      restopicsnap.data![i -
                                                          widget.resturant
                                                              .restopic.length],
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : InkWell(
                                                    onLongPress: () {
                                                      showremovedilog(
                                                        size,
                                                        context,
                                                        () async {
                                                          if (restourlsnap.data!
                                                                  .length >
                                                              1) {
                                                            List<String> _z =
                                                                [];
                                                            _z = restourlsnap
                                                                .data!;
                                                            await FirebaseHelper
                                                                .removeimagefromurl(
                                                              _z[i],
                                                            );
                                                            _z.removeAt(i);
                                                            await FirebaseHelper
                                                                .restoimgeurl(
                                                              widget
                                                                  .resturant.id,
                                                              _z,
                                                              false,
                                                            );
                                                            _bloc.restourl = _z;
                                                            _restourls.sink
                                                                .add(_z);
                                                          } else {
                                                            snack(
                                                              "Alert !",
                                                              "You have to take 1 image in !",
                                                              true,
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: CustomNetworkImage(
                                                      image:
                                                          restourlsnap.data![i],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        InkWell(
                                          onTap: () async {
                                            File? _image = await chooseimage();
                                            if (_image != null) {
                                              if (restopicsnap.data!.isEmpty) {
                                                _bloc.restopic.add(_image);
                                                _resto.sink.add([_image]);
                                              } else {
                                                List<File> _pics = [];
                                                _pics = restopicsnap.data!;
                                                _pics.add(_image);
                                                _bloc.restopic = _pics;
                                                _resto.sink.add(_pics);
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
                            const SizedBox(height: 15),
                            CustomLable(
                              size: size,
                              title: "$displaystr $restaurantsstr",
                              language: englishlangstr,
                            ),
                            StreamBuilder<String?>(
                              stream: _display.stream,
                              initialData: widget.resturant.display,
                              builder: (context, displaysnap) {
                                return CustomDropdownWidget(
                                  size: size,
                                  hint: "$displaystr $restaurantsstr",
                                  mainvar: displaysnap.data!,
                                  listofwidget: const ["Yes", "No"],
                                  onchange: (String? value) {
                                    _bloc.display = value!;
                                    _display.sink.add(value);
                                  },
                                  language: englishlangstr,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomLable(
                              size: size,
                              title: "Count",
                              language: englishlangstr,
                            ),
                            CustomTextfeild(
                              size: size,
                              hintstr: "Count",
                              controller: _bloc.numbercontroller,
                              language: englishlangstr,
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
                                    title: "$updatestr $restaurantsstr",
                                    func: () {
                                      _bloc.editresturant(
                                        widget.resturant.id,
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
                                    title: "$deletestr $restaurantsstr",
                                    func: () {
                                      _bloc.deleteresto(
                                        widget.resturant.id,
                                      );
                                    },
                                    color: redcolor,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomLable(
                                    size: size,
                                    title: adddishestr,
                                    language: englishlangstr,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.42,
                                  child: CustomButton(
                                    size: size,
                                    title: adddishestr,
                                    func: () {
                                      routepush(
                                        context,
                                        DishAddScreen(
                                          taglist: taglistsnap.data!,
                                          restoid: widget.resturant.id,
                                        ),
                                      );
                                    },
                                    removespace: true,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.05),
                              ],
                            ),
                            const SizedBox(height: 15),
                            StreamBuilder(
                              stream: FirebaseHelper.dishstream(
                                  widget.resturant.id),
                              builder: (context, firesnap) {
                                if (firesnap.connectionState ==
                                    ConnectionState.waiting) {
                                  return loadingwidget();
                                } else if ((firesnap.data as DatabaseEvent)
                                            .snapshot
                                            .value !=
                                        null &&
                                    firesnap.hasData &&
                                    !firesnap.hasError) {
                                  List<DishModel> _dishlist = [];
                                  final Map _data =
                                      ((firesnap.data as DatabaseEvent)
                                          .snapshot
                                          .value as Map);
                                  _data.forEach((key, value) {
                                    _dishlist
                                        .add(DishModel.fromfire(key, value));
                                  });
                                  _bloc.addintodish(_dishlist);
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: _dishlist.length,
                                    itemBuilder: (context, i) =>
                                        CustomTitleIconBtn(
                                      size: size,
                                      title: _dishlist[i].name[englishlangstr],
                                      onclick: () {
                                        routepush(
                                          context,
                                          DishUpdateScreen(
                                            taglist: taglistsnap.data!,
                                            dish: _dishlist[i],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
