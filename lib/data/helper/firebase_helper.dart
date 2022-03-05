import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../domain/all.dart';

class FirebaseHelper {
  static final _fire = FirebaseDatabase.instance;

  static Future<void> removeimagefromurl(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }

  static Future<String> getimageurl(
    String keyword,
    String id,
    File image,
  ) async {
    final ref = FirebaseStorage.instance.ref().child(keyword).child('$id.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  static Future<String> getrestoimageurl(
    String keyword,
    String id,
    String count,
    File image,
  ) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("Resturants")
        .child(id)
        .child(keyword)
        .child('$count.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  static Future<String> getdishimageurl(
    String id,
    String count,
    File image,
  ) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("Dishes")
        .child(id)
        .child('$count.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  static Stream categorytagstream() {
    return _fire.ref("CategoryTags").onValue;
  }

  static Stream categorycountstream() {
    return _fire.ref("CategoryTags/Count").onValue;
  }

  static Stream tagstream() {
    return _fire.ref("CategoryTags/Tags").onValue;
  }

  static Stream pagestream() {
    return _fire.ref("Pages").onValue;
  }

  static Stream notificationstream() {
    return _fire.ref("Notifications").onValue;
  }

  static Stream bannerstream() {
    return _fire.ref("Banners").onValue;
  }

  static Stream resturantstream() {
    return _fire.ref("Resturants").onValue;
  }

  static Stream dishstream(String id) {
    return _fire.ref("Dishes").orderByChild("RestoId").equalTo(id).onValue;
  }

  static Stream adminstream() {
    return _fire
        .ref("Users")
        .orderByChild("UserSection")
        .equalTo("Admin")
        .onValue;
  }

  static Stream userstream() {
    return _fire
        .ref("Users")
        .orderByChild("UserSection")
        .equalTo("Customer")
        .onValue;
  }

  static Future<bool> addtagfire(
    String nameenglish,
    String namearebic,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("CategoryTags/Tags")
        .orderByChild(englishlangstr)
        .equalTo(nameenglish)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("CategoryTags/Tags").push().set({
        englishlangstr: nameenglish,
        arabiclangstr: namearebic,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<void> edittagfire(
    String id,
    String nameenglish,
    String namearebic,
  ) async {
    await _fire.ref("CategoryTags/Tags/$id").update({
      englishlangstr: nameenglish,
      arabiclangstr: namearebic,
    });
  }

  static Future<void> deletetagfire(String id) async {
    _fire.ref("CategoryTags/Tags/$id").remove();
  }

  static Future<bool> addcategoryfire(
    int number,
    String nameenglish,
    String namearabic,
    List<String> tags,
    String displaytype,
    File image,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("CategoryTags/Category")
        .orderByChild("NameEnglish")
        .equalTo(nameenglish)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("CategoryTags/Category").push().set({
        "Number": number,
        "NameEnglish": nameenglish,
        "NameArabic": namearabic,
        "DisplayType": displaytype,
        "Tags": tags,
      });
      String _id = "";
      await _fire
          .ref("CategoryTags/Category")
          .orderByChild("NameEnglish")
          .equalTo(nameenglish)
          .once()
          .then(
        (DatabaseEvent dataevent) {
          (dataevent.snapshot.value as Map).forEach(
            (key, value) {
              _id = key;
            },
          );
        },
      );
      final String _url = await getimageurl('Category', _id, image);
      await _fire.ref("CategoryTags/Category/$_id/Image").set(_url);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editcategoryfire(
    String id,
    int number,
    String nameenglish,
    String namearabic,
    List<String> tags,
    String displaytype,
    File? image,
  ) async {
    if (image == null) {
      await _fire.ref("CategoryTags/Category/$id").update({
        "Number": number,
        "NameEnglish": nameenglish,
        "NameArabic": namearabic,
        "DisplayType": displaytype,
        "Tags": tags,
      });
    } else {
      final String _url = await getimageurl('Category', id, image);
      await _fire.ref("CategoryTags/Category/$id").update({
        "Number": number,
        "NameEnglish": nameenglish,
        "NameArabic": namearabic,
        "DisplayType": displaytype,
        "Tags": tags,
        "Image": _url,
      });
    }
  }

  static Future<void> deletecategoryfire(String id, String image) async {
    await removeimagefromurl(image);
    await _fire.ref("CategoryTags/Category/$id").remove();
  }

  static Future<bool> addpagefire(
    String titleenglish,
    String titlearabic,
    String contentenglish,
    String contentarabic,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("Pages")
        .orderByChild("TitleEnglish")
        .equalTo(titleenglish)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Pages").push().set({
        "TitleEnglish": titleenglish,
        "TitleArabic": titlearabic,
        "ContentEnglish": contentenglish,
        "ContentArabic": contentarabic,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editpagefire(
    String id,
    String titleenglish,
    String titlearabic,
    String contentenglish,
    String contentarabic,
  ) async {
    await _fire.ref("Pages/$id").update({
      "TitleEnglish": titleenglish,
      "TitleArabic": titlearabic,
      "ContentEnglish": contentenglish,
      "ContentArabic": contentarabic,
    });
  }

  static Future<void> deletepagefire(String id) async {
    await _fire.ref("Pages/$id").remove();
  }

  static Future<bool> addnotificationfire(
    String nameenglish,
    String namearabic,
    String messageenglish,
    String messagearabic,
    String date,
    String time,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("Notifications")
        .orderByChild("NameEnglish")
        .equalTo(nameenglish)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Notifications").push().set({
        "NameEnglish": nameenglish,
        "NameArabic": namearabic,
        "MessageEnglish": messageenglish,
        "MessageArabic": messagearabic,
        "Date": date,
        "Time": time,
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editnotificationfire(
    String id,
    String nameenglish,
    String namearabic,
    String messageenglish,
    String messagearabic,
    String date,
    String time,
  ) async {
    await _fire.ref("Notifications/$id").update({
      "NameEnglish": nameenglish,
      "NameArabic": namearabic,
      "MessageEnglish": messageenglish,
      "MessageArabic": messagearabic,
      "Date": date,
      "Time": time,
    });
  }

  static Future<void> deletenotifire(String id) async {
    await _fire.ref("Notifications/$id").remove();
  }

  static Future<bool> addbannerfire(
    String name,
    String startdate,
    String enddate,
    File image,
  ) async {
    final DatabaseEvent _find =
        await _fire.ref("Banners").orderByChild("Name").equalTo(name).once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Banners").push().set({
        "Name": name,
        "StartDate": startdate,
        "EndDate": enddate,
      });
      String _id = "";
      await _fire.ref("Banners").orderByChild("Name").equalTo(name).once().then(
        (DatabaseEvent dataevent) {
          (dataevent.snapshot.value as Map).forEach(
            (key, value) {
              _id = key;
            },
          );
        },
      );
      final String _url = await getimageurl('Banners', _id, image);
      await _fire.ref("Banners/$_id/Image").set(_url);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editbannerfire(
    String id,
    String name,
    String startdate,
    String enddate,
    File? image,
  ) async {
    if (image == null) {
      await _fire.ref("Banners/$id").update({
        "Name": name,
        "StartDate": startdate,
        "EndDate": enddate,
      });
    } else {
      final String _url = await getimageurl('Banners', id, image);
      await _fire.ref("Banners/$id").update({
        "Name": name,
        "StartDate": startdate,
        "EndDate": enddate,
        "Image": _url,
      });
    }
  }

  static Future<void> deletebannerfire(String id, String image) async {
    await removeimagefromurl(image);
    await _fire.ref("Banners/$id").remove();
  }

  static Future<bool> addresturantfire(
    int number,
    String nameeng,
    String nameare,
    String typeeng,
    String typeara,
    String latitude,
    String longitude,
    String timeeng,
    String timeara,
    String desceng,
    String descara,
    String loceng,
    String locara,
    List<String> taginit,
    List<File> profilepics,
    List<File> restopics,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("Resturants")
        .orderByChild("NameEnglish")
        .equalTo(nameeng)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Resturants").push().set({
        "Number": number,
        "NameEnglish": nameeng,
        "NameArabic": nameare,
        "TypeEnglish": typeeng,
        "TypeArabic": typeara,
        "Latitude": latitude,
        "Longitude": longitude,
        "TimmingEnglish": timeeng,
        "TimmingArabic": timeara,
        "DescriptionEnglish": desceng,
        "DescriptionArabic": descara,
        "LocationEnglish": loceng,
        "LocationArabic": locara,
        "Tags": taginit,
        "Display": "Yes",
      });
      String _id = "";
      await _fire
          .ref("Resturants")
          .orderByChild("NameEnglish")
          .equalTo(nameeng)
          .once()
          .then(
        (DatabaseEvent dataevent) {
          (dataevent.snapshot.value as Map).forEach(
            (key, value) {
              _id = key;
            },
          );
        },
      );
      List<String> _profilepic = [];
      for (int i = 0; i < profilepics.length; i++) {
        final String _url = await getrestoimageurl(
          "Profile",
          _id,
          i.toString(),
          profilepics[i],
        );
        _profilepic.add(_url);
      }
      await _fire.ref("Resturants/$_id/ProfileImage").set(_profilepic);
      List<String> _restopic = [];
      for (int i = 0; i < restopics.length; i++) {
        final String _url = await getrestoimageurl(
          "RestoPic",
          _id,
          i.toString(),
          restopics[i],
        );
        _restopic.add(_url);
      }
      await _fire.ref("Resturants/$_id/ResturantImage").set(_restopic);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editresturantfire(
    String id,
    int number,
    String nameeng,
    String nameare,
    String typeeng,
    String typeara,
    String latitude,
    String longitude,
    String timeeng,
    String timeara,
    String desceng,
    String descara,
    String loceng,
    String locara,
    List<String> taginit,
    List<File> profilepics,
    List<File> restopics,
    List<String> profileurlpics,
    List<String> restourlpics,
    String display,
  ) async {
    await _fire.ref("Resturants/$id").update({
      "Number": number,
      "NameEnglish": nameeng,
      "NameArabic": nameare,
      "TypeEnglish": typeeng,
      "TypeArabic": typeara,
      "Latitude": latitude,
      "Longitude": longitude,
      "TimmingEnglish": timeeng,
      "TimmingArabic": timeara,
      "DescriptionEnglish": desceng,
      "DescriptionArabic": descara,
      "Tags": taginit,
      "Display": display,
    });
    if (profilepics.isNotEmpty) {
      List<String> _profilepic = [];
      _profilepic.addAll(profileurlpics);
      for (int i = 0; i < profilepics.length; i++) {
        final String _url = await getrestoimageurl(
          "Profile",
          id,
          (profileurlpics.length + i).toString(),
          profilepics[i],
        );
        _profilepic.add(_url);
      }
      await _fire.ref("Resturants/$id/ProfileImage").set(_profilepic);
    }
    if (restopics.isNotEmpty) {
      List<String> _restopic = [];
      _restopic.addAll(restourlpics);
      for (int i = 0; i < restopics.length; i++) {
        final String _url = await getrestoimageurl(
          "RestoPic",
          id,
          (restourlpics.length + i).toString(),
          restopics[i],
        );
        _restopic.add(_url);
      }
      await _fire.ref("Resturants/$id/ResturantImage").set(_restopic);
    }
  }

  static Future<void> restoimgeurl(
    String id,
    List<String> list,
    bool profile,
  ) async {
    if (profile) {
      await _fire.ref("Resturants/$id/ProfileImage").set(list);
    } else {
      await _fire.ref("Resturants/$id/ResturantImage").set(list);
    }
  }

  static Future<void> deleteresturatfire(
    String id,
    List<String> profilepics,
    List<String> restopics,
    List<DishModel> dishes,
  ) async {
    for (int i = 0; i < profilepics.length; i++) {
      await removeimagefromurl(profilepics[i]);
    }
    for (int i = 0; i < restopics.length; i++) {
      await removeimagefromurl(restopics[i]);
    }
    if (dishes.isNotEmpty) {
      for (int i = 0; i < dishes.length; i++) {
        for (int j = 0; j < dishes[i].images.length; j++) {
          await removeimagefromurl(dishes[i].images[j]);
        }
        await _fire.ref("Dishes/${dishes[i].id}").remove();
      }
    }
    await _fire.ref("Resturants/$id").remove();
  }

  static Future<bool> adddishfire(
    String restoid,
    String nameeng,
    String nameare,
    String desceng,
    String descara,
    String price,
    List<String> tags,
    List<File> images,
  ) async {
    final DatabaseEvent _find = await _fire
        .ref("Dishes")
        .orderByChild("NameEnglish")
        .equalTo(nameeng)
        .once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Dishes").push().set({
        "NameEnglish": nameeng,
        "NameArabic": nameare,
        "DescriptionEnglish": desceng,
        "DescriptionArabic": descara,
        "Price": price,
        "Tags": tags,
        "RestoId": restoid,
      });
      String _id = "";
      await _fire
          .ref("Dishes")
          .orderByChild("NameEnglish")
          .equalTo(nameeng)
          .once()
          .then(
        (DatabaseEvent dataevent) {
          (dataevent.snapshot.value as Map).forEach(
            (key, value) {
              _id = key;
            },
          );
        },
      );
      List<String> _imageurl = [];
      for (int i = 0; i < images.length; i++) {
        final String _url = await getdishimageurl(
          _id,
          i.toString(),
          images[i],
        );
        _imageurl.add(_url);
      }
      await _fire.ref("Dishes/$_id/Images").set(_imageurl);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editdishefire(
    String id,
    String nameeng,
    String nameare,
    String desceng,
    String descara,
    String price,
    List<String> tags,
    List<File> images,
    List<String> urls,
  ) async {
    await _fire.ref("Dishes/$id").update({
      "NameEnglish": nameeng,
      "NameArabic": nameare,
      "DescriptionEnglish": desceng,
      "DescriptionArabic": descara,
      "Price": price,
      "Tags": tags,
    });
    if (images.isNotEmpty) {
      List<String> _imageurl = [];
      _imageurl.addAll(urls);
      for (int i = 0; i < images.length; i++) {
        final String _url = await getdishimageurl(
          id,
          i.toString(),
          images[i],
        );
        _imageurl.add(_url);
      }
      await _fire.ref("Dishes/$id/Images").set(_imageurl);
    }
  }

  static Future<void> dishimaheurl(String id, List<String> list) async {
    await _fire.ref("Dishes/$id/Images").set(list);
  }

  static Future<void> deletedishfire(String id, List<String> images) async {
    for (int i = 0; i < images.length; i++) {
      await removeimagefromurl(images[i]);
    }
    await _fire.ref("Dishes/$id").remove();
  }

  static Future<bool> addadminfire(
    String email,
    String password,
    String name,
    String usertype,
    String resto,
    String date,
  ) async {
    final DatabaseEvent _find =
        await _fire.ref("Users").orderByChild("Email").equalTo(email).once();
    if (_find.snapshot.value == null) {
      await _fire.ref("Users").push().set({
        "Email": email,
        "Password": password,
        "Name": name,
        "UserType": usertype,
        "Resturant": resto,
        "Date": date,
        "UserSection": "Admin",
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<void> editadminfire(
    String id,
    String name,
    String usertype,
    String resto,
  ) async {
    await _fire.ref("Users/$id").update({
      "Name": name,
      "UserType": usertype,
      "Resturant": resto,
    });
  }

  static Future<void> deleteadminfire(String id) async {
    await _fire.ref("Users/$id").remove();
  }

  static Future<String> loginfire(
    String email,
    String password,
    Function store,
  ) async {
    String rtnstr = "Go";
    await _fire.ref("Users").orderByChild("Email").equalTo(email).once().then(
      (DatabaseEvent event) {
        if (event.snapshot.value == null) {
          rtnstr = "Email Id is not Found !";
        } else {
          (event.snapshot.value as Map).forEach((key, value) async {
            if (value["UserSection"] == "Admin" ||
                value["UserSection"] == "Super") {
              if (password != value["Password"]) {
                rtnstr = "Password is Wrong !";
              } else {
                final SharedPreferences _pref =
                    await SharedPreferences.getInstance();
                await _pref.setString("Email", email);
                await _pref.setString("Password", password);
                await _pref.setString("UserType", value["UserType"] ?? "Super");
                await _pref.setString(
                  "UserResto",
                  value["Resturant"] ?? "Super",
                );
                store(
                  value["UserType"] ?? "Super",
                  value["Resturant"] ?? "Super",
                );
              }
            } else {
              rtnstr = "Email Id  is not found !";
            }
          });
        }
      },
    );
    return rtnstr;
  }

  static Future<bool> forgotfire(String email, String password) async {
    final DatabaseEvent _find =
        await _fire.ref("Users").orderByChild("Email").equalTo(email).once();
    if (_find.snapshot.value != null) {
      String _id = "";
      (_find.snapshot.value as Map).forEach((key, value) {
        _id = key;
      });
      await _fire.ref("Users/$_id/Password").set(password);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> getnameandidofresto(Function done) async {
    List<String> _name = [];
    List<String> _id = [];
    await _fire.ref("Resturants").once().then(
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          (event.snapshot.value as Map).forEach((key, value) {
            _id.add(key);
            _name.add(value["NameEnglish"]);
          });
        }
      },
    );
    done(_name, _id);
  }

  static Future<void> getlistoftags(Function done) async {
    List<TagModel> _tags = [];
    await _fire.ref("CategoryTags/Tags").once().then(
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          (event.snapshot.value as Map).forEach((key, value) {
            _tags.add(TagModel.fromfire(key, value));
          });
        }
      },
    );
    done(_tags);
  }
}
