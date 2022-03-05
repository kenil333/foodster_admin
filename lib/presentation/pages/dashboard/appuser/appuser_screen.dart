import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class AppUsersScreen extends StatefulWidget {
  const AppUsersScreen({Key? key}) : super(key: key);

  @override
  State<AppUsersScreen> createState() => _AppUsersScreenState();
}

class _AppUsersScreenState extends State<AppUsersScreen> {
  final _bloc = AppUserBloc();

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
                  stream: FirebaseHelper.userstream(),
                  builder: (context, firesnap) {
                    if (firesnap.connectionState == ConnectionState.waiting) {
                      return loadingwidget();
                    } else if ((firesnap.data as DatabaseEvent)
                                .snapshot
                                .value !=
                            null &&
                        firesnap.hasData &&
                        !firesnap.hasError) {
                      List<AppUserModel> _list = [];
                      final Map _data = ((firesnap.data as DatabaseEvent)
                          .snapshot
                          .value as Map);
                      _data.forEach((key, value) {
                        _list.add(AppUserModel.fromfire(key, value));
                      });
                      _bloc.setlist(_list);
                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 100,
                          top: 15,
                        ),
                        itemCount: _list.length,
                        itemBuilder: (context, i) => CustomTitleIconBtn(
                          size: size,
                          title: _list[i].name,
                          onclick: () {
                            routepush(
                              context,
                              AppUserDetailScreen(
                                appuser: _list[i],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: nodatafound(),
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
