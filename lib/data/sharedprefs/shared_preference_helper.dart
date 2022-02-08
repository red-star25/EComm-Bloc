import 'dart:async';

import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // shared pref instance
  final SharedPreferences _sharedPreference;

  // General Methods: ----------------------------------------------------------
  Future<String?> get isNewUser async {
    return _sharedPreference.getString(Preferences.is_new_user);
  }

  Future<bool> setIsNewuser({required bool isNewUser}) async {
    return _sharedPreference.setBool(Preferences.is_new_user, isNewUser);
  }

  // Login Methods: -----------------------------------------------------------
  Future<String?> get isLoggedIn async {
    return _sharedPreference.getString(Preferences.is_logged_in);
  }

  Future<bool> setIsLoggedIn({required bool isLoggedIn}) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, isLoggedIn);
  }

  // User Methods: ------------------------------------------------------------
  String? get userId {
    return _sharedPreference.getString(Preferences.user_id);
  }
}
