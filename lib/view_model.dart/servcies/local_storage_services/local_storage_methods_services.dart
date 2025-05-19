import 'package:tms_mobileapp/view_model.dart/servcies/local_storage_services/shared_preferences.dart';

class LocalStorageMethods {
  LocalStorageMethods._();
  static final instance = LocalStorageMethods._();

  Future<void> writeUserApiToken(String token) async {
    await Prefs.setString("api_token", token);
  }

  String? getUserApiToken() {
    String? token = Prefs.getString("api_token");
    return token;
  }

  // Write the Username
  Future<void> writeUsername(String name) async {
    await Prefs.setString("name", name);
  }

  Future<void> writeTasksProjectname(String name) async {
    await Prefs.setString("name1", name);
  }

  Future<void> writecomment(int comment) async {
    await Prefs.setInt("comment", comment);
  }

  Future<void> writeAttachment(int attachment) async {
    await Prefs.setInt("attachment", attachment);
  }

  Future<void> writechecklist(int checklist) async {
    await Prefs.setInt("checklist", checklist);
  }

  Future<void> getcomment(int comment) async {
    Prefs.getInt("comment");
  }

  Future<void> getAttachment(int attachment) async {
    Prefs.getInt("attachment");
  }

  Future<void> getchecklist(int checklist) async {
    Prefs.getInt("checklist");
  }

  // Get the stored Username
  String? getUsername() {
    String? name = Prefs.getString("name");
    return name;
  }

  // Get the stored Username
  String? getTaskProjectname() {
    String? name = Prefs.getString("name1");
    return name;
  }

  // Clear all stored data
  Future<void> clear() async {
    await Prefs.remove("api_token");
    await Prefs.remove("name");
  }
}
