import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  final _bloc = AdminBloc();

  @override
  void dispose() {
    _bloc.email.dispose();
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder(
                  stream: FirebaseHelper.adminstream(),
                  builder: (context, firesnap) {
                    if (firesnap.connectionState == ConnectionState.waiting) {
                      return loadingwidget();
                    } else if ((firesnap.data as DatabaseEvent)
                                .snapshot
                                .value !=
                            null &&
                        firesnap.hasData &&
                        !firesnap.hasError) {
                      List<AdminModel> _list = [];
                      final Map _data = ((firesnap.data as DatabaseEvent)
                          .snapshot
                          .value as Map);
                      _data.forEach((key, value) {
                        _list.add(AdminModel.fromfire(key, value));
                      });
                      _bloc.setlist(_list);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomButton(
                              size: size,
                              title: adduserstr,
                              func: () {
                                routepush(context, const AdminAddScreen());
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(bottom: 100, top: 15),
                              itemCount: _list.length,
                              itemBuilder: (context, i) => CustomTitleIconBtn(
                                size: size,
                                title: _list[i].name,
                                onclick: () {
                                  routepush(
                                    context,
                                    AdminDetailScreen(
                                      admin: _list[i],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            "Please Add Admin User",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              color: primarycol,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            size: size,
                            title: adduserstr,
                            func: () {
                              routepush(context, const AdminAddScreen());
                            },
                          ),
                          Expanded(child: Container()),
                        ],
                      );
                    }
                  },
                ),
                Positioned(
                  bottom: size.height * 0.015,
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: CustomTextfeild(
                            size: size,
                            hintstr: emailstr,
                            controller: _bloc.email,
                            lowmargin: true,
                            language: englishlangstr,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        SizedBox(
                          width: size.width * 0.3,
                          child: CustomButton(
                            size: size,
                            title: exportstr,
                            func: () async {
                              _bloc.exportcsv();
                            },
                            removespace: true,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
