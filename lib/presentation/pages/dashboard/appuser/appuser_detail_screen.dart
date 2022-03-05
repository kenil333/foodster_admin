import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../../domain/all.dart';

class AppUserDetailScreen extends StatelessWidget {
  final AppUserModel appuser;
  const AppUserDetailScreen({Key? key, required this.appuser})
      : super(key: key);

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
                  CustomContainer(size: size, containervalue: appuser.name),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: emailstr,
                    language: englishlangstr,
                  ),
                  CustomContainer(size: size, containervalue: appuser.email),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: phonenumberstr,
                    language: englishlangstr,
                  ),
                  CustomContainer(size: size, containervalue: appuser.phone),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: cretedonstr,
                    language: englishlangstr,
                  ),
                  CustomContainer(
                    size: size,
                    containervalue:
                        DateFormat("dd-MM-yyyy").format(appuser.date),
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: bookmarkstr,
                    language: englishlangstr,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: 3,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: containerdeco,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  restaurantsstr,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: txtcol,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  appuser.restobookmarks.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    color: greencol,
                                    fontFamily: secondaryfontfamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Container(
                            decoration: containerdeco,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  dishestr,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: txtcol,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  appuser.dishbookmarks.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    color: greencol,
                                    fontFamily: secondaryfontfamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomLable(
                    size: size,
                    title: viewstr,
                    language: englishlangstr,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: 3,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: containerdeco,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  restaurantsstr,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: txtcol,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  appuser.restoviews.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    color: greencol,
                                    fontFamily: secondaryfontfamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Container(
                            decoration: containerdeco,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  dishestr,
                                  style: TextStyle(
                                    fontSize: size.width * 0.05,
                                    color: txtcol,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  appuser.dishviews.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.08,
                                    color: greencol,
                                    fontFamily: secondaryfontfamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
