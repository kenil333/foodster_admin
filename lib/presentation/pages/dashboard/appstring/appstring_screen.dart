import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class AppStringScreen extends StatefulWidget {
  const AppStringScreen({Key? key}) : super(key: key);

  @override
  State<AppStringScreen> createState() => _AppStringScreenState();
}

class _AppStringScreenState extends State<AppStringScreen> {
  final TextEditingController _search = TextEditingController();
  final _searchstring = StringStream();

  @override
  void dispose() {
    _search.dispose();
    _searchstring.dispose();
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
            child: StreamBuilder<String?>(
              stream: _searchstring.stream,
              initialData: null,
              builder: (context, searchsnap) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      CustomTextfeild(
                        size: size,
                        hintstr: "$searchstr String",
                        controller: _search,
                        language: englishlangstr,
                        onchange: (String searchvalue) {
                          _searchstring.sink.add(searchvalue);
                        },
                      ),
                      const SizedBox(height: 15),
                      StreamBuilder(
                        stream: FirebaseHelper.appstringstream(),
                        builder: (context, firesnap) {
                          if (firesnap.connectionState ==
                              ConnectionState.waiting) {
                            return loadingwidget();
                          } else {
                            List<AppString> _list = [];
                            _list = ((firesnap.data as DatabaseEvent)
                                    .snapshot
                                    .value as List)
                                .map((e) => AppString.fromfire(e))
                                .toList();
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 20),
                              itemCount: _list.length,
                              itemBuilder: (context, i) => (searchsnap.data ==
                                          null ||
                                      searchsnap.data!.isEmpty)
                                  ? CustomTitleIconBtn(
                                      size: size,
                                      title: _list[i].string[englishlangstr],
                                      onclick: () {
                                        routepush(
                                          context,
                                          AppStringEditScreen(
                                            index: i,
                                            appstring: _list[i],
                                          ),
                                        );
                                      },
                                    )
                                  : _list[i]
                                          .string[englishlangstr]
                                          .toLowerCase()
                                          .startsWith(
                                              searchsnap.data!.toLowerCase())
                                      ? CustomTitleIconBtn(
                                          size: size,
                                          title:
                                              _list[i].string[englishlangstr],
                                          onclick: () {
                                            routepush(
                                              context,
                                              AppStringEditScreen(
                                                index: i,
                                                appstring: _list[i],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
