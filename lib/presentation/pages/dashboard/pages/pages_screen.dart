import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({Key? key}) : super(key: key);

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  final TextEditingController _search = TextEditingController();
  final _searchstring = StringStream();

  @override
  void dispose() {
    _searchstring.dispose();
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                StreamBuilder<String?>(
                  stream: _searchstring.stream,
                  initialData: null,
                  builder: (context, searchsnap) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          CustomTextfeild(
                            size: size,
                            hintstr: "$searchstr $pagestr",
                            controller: _search,
                            language: englishlangstr,
                            onchange: (String searchvalue) {
                              _searchstring.sink.add(searchvalue);
                            },
                          ),
                          const SizedBox(height: 15),
                          StreamBuilder(
                            stream: FirebaseHelper.pagestream(),
                            builder: (context, firesnap) {
                              if (firesnap.connectionState ==
                                  ConnectionState.waiting) {
                                return loadingwidget();
                              } else if ((firesnap.data as DatabaseEvent)
                                          .snapshot
                                          .value !=
                                      null &&
                                  firesnap.hasData &&
                                  !firesnap.hasError) {
                                List<PageModel> _list = [];
                                final Map _data =
                                    ((firesnap.data as DatabaseEvent)
                                        .snapshot
                                        .value as Map);
                                _data.forEach(
                                  (key, value) {
                                    _list.add(PageModel.fromfire(key, value));
                                  },
                                );
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 100),
                                  itemCount: _list.length,
                                  itemBuilder: (context, i) =>
                                      (searchsnap.data == null ||
                                              searchsnap.data!.isEmpty)
                                          ? CustomTitleIconBtn(
                                              size: size,
                                              title: _list[i]
                                                  .title[englishlangstr]!,
                                              onclick: () {
                                                routepush(
                                                  context,
                                                  PageEditScreen(
                                                    page: _list[i],
                                                  ),
                                                );
                                              },
                                            )
                                          : _list[i]
                                                  .title[englishlangstr]!
                                                  .toLowerCase()
                                                  .startsWith(searchsnap.data!
                                                      .toLowerCase())
                                              ? CustomTitleIconBtn(
                                                  size: size,
                                                  title: _list[i]
                                                      .title[englishlangstr]!,
                                                  onclick: () {
                                                    routepush(
                                                      context,
                                                      PageEditScreen(
                                                        page: _list[i],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                );
                              } else {
                                return Center(
                                  child: nodatafound(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: size.width,
                    child: CustomButton(
                      size: size,
                      title: "$addstr $pagestr",
                      func: () {
                        routepush(context, const PageAddScreen());
                      },
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
