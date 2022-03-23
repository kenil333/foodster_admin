import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appstate = Get.put(AppState());
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
                SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: () async {
                              final SharedPreferences _pref =
                                  await SharedPreferences.getInstance();
                              await _pref.setString("Email", "null");
                              await _pref.setString("Password", "null");
                              await _pref.setString("UserType", "null");
                              await _pref.setString("Resturant", "null");
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Icon(
                              Icons.logout_rounded,
                              size: 28,
                              color: whit,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(height: 15),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: restaurantsstr,
                            onclick: () {
                              routepush(context, const ResturantHomeScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: appuserstr,
                            onclick: () {
                              routepush(context, const AppUsersScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: adminuserstr,
                            onclick: () {
                              routepush(context, const AdminUserScreen());
                            },
                          ),
                    CustomTitleIconBtn(
                      size: size,
                      title: analysticstr,
                      onclick: () {
                        routepush(
                          context,
                          AnalysticScreen(
                            usertype: _appstate.usertyperx.value,
                            resto: _appstate.restorx.value,
                          ),
                        );
                      },
                    ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: adbannerstr,
                            onclick: () {
                              routepush(context, const AdbannerListScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: pushnotificationstr,
                            onclick: () {
                              routepush(
                                  context, const PushNotificationScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: pagestr,
                            onclick: () {
                              routepush(context, const PagesScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: categoriestr,
                            onclick: () {
                              routepush(context, const CategoryTagScreen());
                            },
                          ),
                    _appstate.usertyperx.value != "Admin" &&
                            _appstate.usertyperx.value != "Super"
                        ? Container()
                        : CustomTitleIconBtn(
                            size: size,
                            title: "App Strings",
                            onclick: () {
                              routepush(context, const AppStringScreen());
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
