import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _appstate = Get.put(AppState());
  final _bloc = LoginBloc();

  @override
  void dispose() {
    _bloc.email.dispose();
    _bloc.passweod.dispose();
    _bloc.loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        backgroundColor: primarycol,
        title: const Text(
          signinstr,
          style: TextStyle(
            fontFamily: secondaryfontfamily,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SigninImgWid(size: size),
            const SizedBox(height: 20),
            // CustomTextfeild(
            //   size: size,
            //   hintstr: namestr,
            //   controller: _name,
            //   language: englishlangstr,
            // ),
            // const SizedBox(height: 20),
            CustomTextfeild(
              size: size,
              hintstr: emailstr,
              controller: _bloc.email,
              language: englishlangstr,
            ),
            const SizedBox(height: 20),
            CustomTextfeild(
              size: size,
              hintstr: passwordstr,
              controller: _bloc.passweod,
              language: englishlangstr,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    routepush(context, const ForgotPasswordScreen());
                  },
                  child: Text(
                    "$forgotstr $passwordstr !",
                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      color: primarycol,
                      fontFamily: secondaryfontfamily,
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),
              ],
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
                    title: signinstr,
                    func: () {
                      _bloc.login(
                        () {
                          routepushreplash(context, const DashboardScreen());
                          // Navigator.pushAndRemoveUntil<dynamic>(
                          //   context,
                          //   MaterialPageRoute<dynamic>(
                          //     builder: (BuildContext context) =>
                          //         const DashboardScreen(),
                          //   ),
                          //   (route) => false,
                          // );
                        },
                        (String usertype, String resto) {
                          _appstate.changedata(usertype, resto);
                        },
                      );
                      // routepushreplash(context, const DashboardScreen());
                    },
                  );
                }
              },
            ),

            // const SizedBox(height: 30),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            //   child: Text(
            //     termsofconditionstr,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: size.width * 0.036,
            //       color: grycol,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
