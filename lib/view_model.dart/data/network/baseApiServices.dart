class BaseApiservices {
  static const String baseUrl = 'http://tms-hawari.innovabe.com';
  static const String baseUrl2 = 'http://192.168.10.15:8000';

  static const String login = '$baseUrl/api/login';
  static const String logout = '$baseUrl/api/logout';
  static const String fetchProject = '$baseUrl/api/projects';
  static const String fetchProjecttask = '$baseUrl/api/projects_task/';
  static const String fetchtaskData = '$baseUrl/api/task/';

  static const String imgurl = '$baseUrl/storage/';

  static const String uploadImage = '$baseUrl/api/task/';
}
