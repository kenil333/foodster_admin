import 'package:shared_preferences/shared_preferences.dart';

import './../../../domain/all.dart';

class SplashBloc {
  autologin(
    Function success,
    Function notsuccess,
    Function store,
  ) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    final String _email = _pref.getString("Email") ?? "null";
    final String _password = _pref.getString("Password") ?? "null";
    if (_email == "null" || _password == "null") {
      notsuccess();
    } else {
      await FirebaseHelper.loginfire(_email, _password, store).then(
        (String result) {
          if (result == "Go") {
            success();
          } else {
            notsuccess();
          }
        },
      );
    }
  }
}
