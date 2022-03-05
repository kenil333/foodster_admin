import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _bloc = ForgotBloc();

  @override
  void dispose() {
    _bloc.email.dispose();
    _bloc.password.dispose();
    _bloc.confirmpassword.dispose();
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
          "$forgotstr $passwordstr",
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
              controller: _bloc.password,
              language: englishlangstr,
            ),
            const SizedBox(height: 20),
            CustomTextfeild(
              size: size,
              hintstr: "$confirmstr $passwordstr",
              controller: _bloc.confirmpassword,
              language: englishlangstr,
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
                    title: forgotstr,
                    func: () {
                      _bloc.forgotpass();
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
