import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class AdminDetailScreen extends StatefulWidget {
  final AdminModel admin;
  const AdminDetailScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<AdminDetailScreen> createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminDetailScreen> {
  final _bloc = AdminEditBloc();
  final _usertype = StringStream();
  final _resto = StringStream();
  final _namelist = ListStringStream();
  final _idlist = ListStringStream();
  final _loading = BoolStream();

  @override
  void initState() {
    _bloc.initfunction(
      widget.admin.name,
      widget.admin.email,
      widget.admin.password,
      widget.admin.usertype,
      widget.admin.resturant,
    );
    Future.delayed(const Duration(seconds: 0)).then((_) async {
      await FirebaseHelper.getnameandidofresto(
        (List<String> namelist, List<String> idlist) {
          _namelist.sink.add(namelist);
          _idlist.sink.add(idlist);
          _loading.sink.add(false);
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.name.dispose();
    _bloc.email.dispose();
    _bloc.password.dispose();
    _bloc.loading.dispose();
    _usertype.dispose();
    _resto.dispose();
    _namelist.dispose();
    _idlist.dispose();
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
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: namestr,
                    language: englishlangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: namestr,
                    controller: _bloc.name,
                    language: englishlangstr,
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: emailstr,
                    language: englishlangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: emailstr,
                    controller: _bloc.email,
                    language: englishlangstr,
                    enable: false,
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: passwordstr,
                    language: englishlangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: passwordstr,
                    controller: _bloc.password,
                    language: englishlangstr,
                    obsecured: true,
                    enable: false,
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: usertypestr,
                    language: englishlangstr,
                  ),
                  StreamBuilder<bool>(
                    stream: _loading.stream,
                    initialData: true,
                    builder: (context, loadsnap) {
                      if (loadsnap.data!) {
                        return loadingwidget();
                      } else {
                        return StreamBuilder<List<String>>(
                          stream: _namelist.stream,
                          initialData: const [],
                          builder: (context, namesnap) =>
                              StreamBuilder<List<String>>(
                            stream: _idlist.stream,
                            initialData: const [],
                            builder: (context, idsnap) =>
                                StreamBuilder<String?>(
                              stream: _usertype.stream,
                              initialData: widget.admin.usertype,
                              builder: (context, usertypesnap) {
                                return StreamBuilder<String?>(
                                  stream: _resto.stream,
                                  initialData: widget.admin.resturant ==
                                          "All Restaurants"
                                      ? "All Restaurants"
                                      : namesnap.data![idsnap.data!.indexWhere(
                                          (element) =>
                                              element ==
                                              widget.admin.resturant)],
                                  builder: (context, resosnap) {
                                    List<String> _restoname = [];
                                    if (usertypesnap.data == adminstr) {
                                      _restoname.add("All Restaurants");
                                      _restoname.addAll(namesnap.data!);
                                    } else {
                                      _restoname = namesnap.data!;
                                    }
                                    return Column(
                                      children: [
                                        CustomDropdownWidget(
                                          size: size,
                                          hint: usertypestr,
                                          mainvar: usertypesnap.data,
                                          listofwidget: const [
                                            adminstr,
                                            restaurantsstr,
                                          ],
                                          onchange: (String? value) {
                                            if (value != adminstr) {
                                              _resto.sink.add(null);
                                            }
                                            _bloc.usertype = value!;
                                            _usertype.sink.add(value);
                                          },
                                          language: englishlangstr,
                                        ),
                                        const SizedBox(height: 15),
                                        CustomLable(
                                          size: size,
                                          title: selectrestostr,
                                          language: englishlangstr,
                                        ),
                                        CustomDropdownWidget(
                                          size: size,
                                          hint: selectrestostr,
                                          mainvar: resosnap.data,
                                          listofwidget: _restoname,
                                          onchange: (String? value) {
                                            if (usertypesnap.data == adminstr) {
                                              if (value == "All Restaurants") {
                                                _bloc.resto = value!;
                                                _resto.sink.add(value);
                                              } else {
                                                final _index = namesnap.data!
                                                    .indexWhere((element) =>
                                                        element == value);
                                                _bloc.resto =
                                                    idsnap.data![_index];
                                                _resto.sink.add(value);
                                              }
                                            } else {
                                              final _index = namesnap.data!
                                                  .indexWhere((element) =>
                                                      element == value);
                                              _bloc.resto =
                                                  idsnap.data![_index];
                                              _resto.sink.add(value);
                                            }
                                          },
                                          language: englishlangstr,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: cretedonstr,
                    language: englishlangstr,
                  ),
                  CustomContainer(
                    size: size,
                    containervalue:
                        DateFormat("dd-MM-yyyy").format(widget.admin.date),
                  ),
                  const SizedBox(height: 50),
                  StreamBuilder<bool>(
                    stream: _bloc.loading.stream,
                    initialData: false,
                    builder: (context, loadingsnap) {
                      if (loadingsnap.data!) {
                        return loadingwidget();
                      } else {
                        return Row(
                          children: [
                            SizedBox(width: size.width * 0.05),
                            Expanded(
                              child: CustomButton(
                                size: size,
                                title: deleteuserstr,
                                func: () {
                                  _bloc.deleteadmin(widget.admin.id);
                                },
                                removespace: true,
                                color: redcolor,
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Expanded(
                              child: CustomButton(
                                size: size,
                                title: savechangestr,
                                func: () {
                                  _bloc.editadmin(widget.admin.id);
                                },
                                removespace: true,
                              ),
                            ),
                            SizedBox(width: size.width * 0.05),
                          ],
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
