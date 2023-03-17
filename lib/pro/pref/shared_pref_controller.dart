import 'package:shared_preferences/shared_preferences.dart';

import '../models/student.dart';

enum PrefKeys { id, fullName, email, gender, token, isLoggedIn }

class SharedPrefController {
  static SharedPrefController? _instance;
  late SharedPreferences _sharedPreferences;
  SharedPrefController._();

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }
  Future<void> initPrefweences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(PrefKeys.isLoggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, student.id);
    await _sharedPreferences.setString(
        PrefKeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(PrefKeys.email.name, student.email);
    await _sharedPreferences.setString(PrefKeys.gender.name, student.gender);
    await _sharedPreferences.setString(
        PrefKeys.token.name, 'Bearer ${student.token}');
  }

  Future<bool> clear() async => _sharedPreferences.clear();
  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.isLoggedIn.name) ?? false;
  T? getByKey<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  String get token => _sharedPreferences.getString(PrefKeys.token.name) ?? '';
}
