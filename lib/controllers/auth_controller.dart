// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/view_model.dart/servcies/local_storage_services/local_storage_methods_services.dart';
import 'package:tms_mobileapp/routes/pages.dart';

import '../view_model.dart/data/response/app_exception.dart';
import '../view_model.dart/respository/auth_repository.dart';

class AuthController extends GetxController {
  final repository = AuthRepositpory();
  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  void login() async {
    isLoading.value = true; // Start loading indicator

    Map<String, dynamic> data = {
      'email': emailController.value.text,
      'password': passwordController.value.text
    };

    try {
      final response = await repository.loginApi(data);
      if (response != null && response["status"] == 200) {
        // Get.snackbar(
        //   'Login',
        //   'Login Successfully',
        //   snackPosition: SnackPosition.BOTTOM,
        //   maxWidth: 2,
        //   backgroundColor: kPrimaryColor,
        //   colorText: Colors.white,
        // );
        isLoading.value = false;
        Get.offNamed(Pages.home);
      }
    } on NoInternetException catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } on TimeoutException catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout(BuildContext context) {
    final token = LocalStorageMethods.instance.getUserApiToken();
    print('LogoutTken $token');
    if (token == null) {
      print('no token found');
    }
    repository.logoutApi(token, context).then((value) {
      Get.snackbar('Logout', 'Logged out successfully');
      Get.toNamed(Pages.signin);
    }).onError((error, stackTrace) {
      isLoading.value = false;
      Get.snackbar('Logout', error.toString());
      print(error);
    });
  }
}
