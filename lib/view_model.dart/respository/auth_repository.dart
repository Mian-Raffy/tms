import 'package:flutter/material.dart';

import '../servcies/local_storage_services/local_storage_methods_services.dart';
import '../data/network/baseApiServices.dart';
import '../data/network/network_api_services.dart';
import '../../routes/pages.dart';
import '../../model/task_model.dart';

class AuthRepositpory {
  late TaskModel taskModel;
  final apiServices = NetworkApiServices();
//Login Function.
  Future<dynamic> loginApi(var data) async {
    // Make the POST request
    dynamic response =
        await apiServices.postRequest(BaseApiservices.login, data);

    // Log the response for debugging
    print('Response LOGIN: $response');

    if (response != null && response["status"] == 200) {
      // Store token and user details on success
      print('Token: ${response["token"]}');
      await LocalStorageMethods.instance
          .writeUserApiToken(response["token"] ?? '');
      await LocalStorageMethods.instance
          .writeUsername(response["user"]["name"] ?? '');

      return response;
    } else {
      return response;
    }
  }

//Logout Funtion
  Future<dynamic> logoutApi(String? token, BuildContext context) async {
    if (token == null) {
      throw Exception("Token is null");
    }

    dynamic response =
        await apiServices.postRequest(BaseApiservices.logout, token);

    await LocalStorageMethods.instance.clear();
    Navigator.pushNamed(context, Pages.signin);
    return response;
  }
}
