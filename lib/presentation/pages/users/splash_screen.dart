import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _appstate = Get.put(AppState());
  final _bloc = SplashBloc();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      _bloc.autologin(
        () {
          routepushreplash(context, const DashboardScreen());
        },
        () {
          routepushreplash(context, const LoginScreen());
        },
        (String usertype, String resto) {
          _appstate.changedata(usertype, resto);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double toppad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: screenback,
      appBar: appbarpref(false, primarycol),
      body: Container(
        padding: EdgeInsets.only(bottom: toppad),
        width: size.width,
        height: size.height,
        color: primarycol,
        child: Center(
          child: Image.asset(
            splashiconimg,
            width: size.width * 0.9,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
