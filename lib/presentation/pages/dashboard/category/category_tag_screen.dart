import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './../../../../domain/all.dart';

class CategoryTagScreen extends StatefulWidget {
  const CategoryTagScreen({Key? key}) : super(key: key);

  @override
  State<CategoryTagScreen> createState() => _CategoryTagScreenState();
}

class _CategoryTagScreenState extends State<CategoryTagScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabcontroller;
  final _selcted = StringStream();

  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller!.dispose();
    _selcted.dispose();
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Stack(
              children: [
                TabBar(
                  controller: _tabcontroller,
                  indicatorColor: primarycol,
                  labelColor: txtcol,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: size.width * 0.042,
                    fontWeight: FontWeight.bold,
                    color: txtcol,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: txtcol,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: const [
                    Tab(
                      text: categoriestr,
                    ),
                    Tab(
                      text: tagstr,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    width: size.width,
                    height: 0.5,
                    color: primarycol,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseHelper.categorytagstream(),
              builder: (context, firesnap) {
                if (firesnap.connectionState == ConnectionState.waiting) {
                  return loadingwidget();
                } else if (firesnap.hasData && !firesnap.hasError) {
                  List<CategoryModel> _caterestolist = [];
                  List<CategoryModel> _catedishlist = [];
                  List<TagModel> _tags = [];
                  if ((firesnap.data as DatabaseEvent).snapshot.value != null) {
                    final Map _data = ((firesnap.data as DatabaseEvent)
                        .snapshot
                        .value as Map);
                    if (_data["Category"] != null) {
                      _data["Category"].forEach((key, value) {
                        if (value["DisplayType"] == restaurantsstr) {
                          _caterestolist
                              .add(CategoryModel.fromfire(key, value));
                        } else {
                          _catedishlist.add(CategoryModel.fromfire(key, value));
                        }
                      });
                    }
                    if (_data["Tags"] != null) {
                      _data["Tags"].forEach((key, value) {
                        _tags.add(TagModel.fromfire(key, value));
                      });
                    }
                  }
                  if (_caterestolist.length > 1) {
                    _caterestolist.sort((a, b) => a.number.compareTo(b.number));
                  }
                  if (_catedishlist.length > 1) {
                    _catedishlist.sort((a, b) => a.number.compareTo(b.number));
                  }
                  return TabBarView(
                    controller: _tabcontroller,
                    children: [
                      StreamBuilder<String?>(
                        stream: _selcted.stream,
                        initialData: restaurantsstr,
                        builder: (context, selstrsnap) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                CustomButton(
                                  size: size,
                                  title: "$addstr $categoriestr",
                                  func: () {
                                    routepush(
                                      context,
                                      CategoryAddScreen(
                                        tags: _tags,
                                        restolenfth: _caterestolist.length,
                                        dishlength: _catedishlist.length,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.06,
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: primarycol,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _selcted.sink.add(restaurantsstr);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: selstrsnap.data ==
                                                      restaurantsstr
                                                  ? primarycol
                                                  : Colors.transparent,
                                            ),
                                            child: Center(
                                              child: Text(
                                                restaurantsstr,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.038,
                                                  color: selstrsnap.data ==
                                                          restaurantsstr
                                                      ? whit
                                                      : primarycol,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _selcted.sink.add(dishestr);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: selstrsnap.data == dishestr
                                                  ? primarycol
                                                  : Colors.transparent,
                                            ),
                                            child: Center(
                                              child: Text(
                                                dishestr,
                                                style: TextStyle(
                                                  fontSize: size.width * 0.038,
                                                  color: selstrsnap.data ==
                                                          dishestr
                                                      ? whit
                                                      : primarycol,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                selstrsnap.data == restaurantsstr
                                    ? _caterestolist.isNotEmpty
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: _caterestolist.length,
                                            itemBuilder: (context, i) =>
                                                CustomTitleIconBtn(
                                              size: size,
                                              title: _caterestolist[i]
                                                  .name[englishlangstr]!,
                                              onclick: () {
                                                routepush(
                                                  context,
                                                  CategoryEditScreen(
                                                    tagslist: _tags,
                                                    category: _caterestolist[i],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.15,
                                            ),
                                            child: nodatafound(),
                                          )
                                    : _catedishlist.isNotEmpty
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: _catedishlist.length,
                                            itemBuilder: (context, i) =>
                                                CustomTitleIconBtn(
                                              size: size,
                                              title: _catedishlist[i]
                                                  .name[englishlangstr]!,
                                              onclick: () {
                                                routepush(
                                                  context,
                                                  CategoryEditScreen(
                                                    tagslist: _tags,
                                                    category: _catedishlist[i],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.15,
                                            ),
                                          ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          );
                        },
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomButton(
                              size: size,
                              title: "$addstr $tagstr",
                              func: () {
                                routepush(context, const TagAddScreen());
                              },
                            ),
                            const SizedBox(height: 10),
                            _tags.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _tags.length,
                                    itemBuilder: (context, i) =>
                                        CustomTitleIconBtn(
                                      size: size,
                                      title: _tags[i].name[englishlangstr]!,
                                      onclick: () {
                                        routepush(
                                          context,
                                          TagEditScreen(
                                            tag: _tags[i],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.15,
                                    ),
                                    child: nodatafound(),
                                  ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return nodatafound();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
