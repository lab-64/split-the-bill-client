import 'package:shared_preferences/shared_preferences.dart';

//TODO redo, when actual login possible
class DummyAuthentication {
  static login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static register(String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('password');
  }
}
