import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './../../../../domain/all.dart';

class AdminAddScreen extends StatefulWidget {
  const AdminAddScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddScreen> createState() => _AdminAddScreenState();
}

class _AdminAddScreenState extends State<AdminAddScreen> {
  final _bloc = AdminAddBloc();
  final _usertype = StringStream();
  final _resto = StringStream();
  final _check = BoolStream();
  final _namelist = ListStringStream();
  final _idlist = ListStringStream();
  final _loading = BoolStream();

  @override
  void initState() {
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
    _bloc.confpassword.dispose();
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
                  const SizedBox(height: 20),
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
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: "$confirmstr $passwordstr",
                    language: englishlangstr,
                  ),
                  CustomTextfeild(
                    size: size,
                    hintstr: "$confirmstr $passwordstr",
                    controller: _bloc.confpassword,
                    language: englishlangstr,
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
                              builder: (context, usertypesnap) {
                                return StreamBuilder<String?>(
                                  stream: _resto.stream,
                                  builder: (context, resosnap) {
                                    debugPrint(
                                        "====> ${namesnap.data!.length}");
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
                  StreamBuilder<bool>(
                    stream: _check.stream,
                    initialData: false,
                    builder: (context, snap) => InkWell(
                      onTap: () {
                        _check.sink.add(!snap.data!);
                        _bloc.sendlogin = !snap.data!;
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: size.width * 0.01,
                          horizontal: size.width * 0.045,
                        ),
                        width: double.infinity,
                        decoration: containerdeco,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              snap.data! ? checksvg : unchecksvg,
                              width: size.width * 0.08,
                              color: txtcol,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              sendlogintoemailstr,
                              style: TextStyle(
                                color: txtcol,
                                fontSize: size.width * 0.045,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  StreamBuilder<bool>(
                    stream: _bloc.loading.stream,
                    initialData: false,
                    builder: (context, loadingsnap) {
                      if (loadingsnap.data!) {
                        return loadingwidget();
                      } else {
                        return CustomButton(
                          size: size,
                          title: addstr,
                          func: () {
                            _bloc.addadmin();
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
