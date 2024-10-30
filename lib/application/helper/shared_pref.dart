import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<SharedPreferences> instance() async {
    var pref = await SharedPreferences.getInstance();
    return pref;
  }

  static dynamic setValue(dynamic key, dynamic value) async {
    if (value is String) {
      await instance().then((pref) {
        pref.setString(key, value);
      });
      return;
    }
    if (value is int) {
      await instance().then((pref) {
        pref.setInt(key, value);
      });
      return;
    }
    if (value is double) {
      await instance().then((pref) {
        pref.setDouble(key, value);
      });
      return;
    }
    if (value is bool) {
      await instance().then((pref) {
        pref.setBool(key, value);
      });
      return;
    }
    if (value is List<String>) {
      await instance().then((pref) {
        pref.setStringList(key, value);
      });
      return;
    }
  }

  static dynamic getValue(dynamic key) async {
    Object? ref;
    var pref = await SharedPreferences.getInstance();
    ref = pref.get(key);
    return ref;
  }

  static Future<bool> removeCache(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}
