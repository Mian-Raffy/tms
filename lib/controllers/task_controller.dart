// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_mobileapp/routes/pages.dart';
import 'package:tms_mobileapp/view_model.dart/data/network/baseApiServices.dart';

import '../model/task_model.dart';
import '../view_model.dart/respository/task_repository.dart';
import 'package:http/http.dart' as http;

import '../view_model.dart/servcies/local_storage_services/local_storage_methods_services.dart';

class TaskController extends GetxController {
  var taskRepository = TaskRepository();
  var tasks = <TaskModel>[].obs;
  var id = ''.obs;

  TaskModel? taskModel;
  Rx<TextEditingController> commentController = TextEditingController().obs;
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  @override
  void onClose() {
    selectedImage.value = null;
    commentController.value.clear();
  }

  RxBool loading = false.obs;
  var taskid = ''.obs;
  var TasktName = ''.obs;
  var projectid = ''.obs;
  var ProjectName = ''.obs;

  var hasInternet = true.obs;

  void saveProjectId(String Id) {
    projectid.value = Id;
  }

  void saveTaskid(String Id) {
    taskid.value = Id;
  }

  void saveProjectName(String name) {
    ProjectName.value = name;
  }

  void saveTaskName(String name) {
    TasktName.value = name;
  }

  void clearModelData() {
    tasks.clear();
    print("Model data cleared.");
  }

  void fetchProject() {
    loading.value = true;
    taskRepository.fetchProject().then((fetchedTasks) {
      hasInternet.value = true;

      tasks.assignAll(fetchedTasks);
      print('All Projects are loaded');
      loading.value = false;
    }).onError((error, StackTrace) {
      loading.value = false;
      hasInternet.value = false;
    });
  }

  void fetchProjecttask(String id) {
    loading.value = true;
    taskRepository.fetchProjectTaskApi(id).then((fetchedTasks) {
      tasks.assignAll(fetchedTasks);
      hasInternet.value = true;

      print('Data of task are loaded');
      loading.value = false;
    }).onError((error, StackTrace) {
      hasInternet.value = false;

      Get.snackbar('Task Load', error.toString());
      print(error);
      loading.value = false;
    });
  }

  void fetchProjectTaskData(String id) {
    taskRepository.fetchTaskData(id).then((fetchedTasks) {
      tasks.assignAll(fetchedTasks);
      hasInternet.value = true;
      print('Data of task are loaded');
    }).onError((error, StackTrace) {
      hasInternet.value = false;
      Get.snackbar('Task Load', error.toString());
      print(error);
    });
  }

  Future<void> pickImage({required ImageSource source}) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
      debugPrint('$e');
    }
  }

  Future<void> uploadImageAsStream(String id) async {
    final token = LocalStorageMethods.instance.getUserApiToken();
    try {
      loading.value = true;
      if (selectedImage.value == null && commentController.value.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please provide either a comment or an image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        loading.value = false;
        return;
      }
      final uri = Uri.parse('${BaseApiservices.uploadImage}+$id');
      final request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = 'Bearer $token';
      if (commentController.value.text.isNotEmpty) {
        request.fields['comment'] = commentController.value.text;
      }
      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            selectedImage.value!.path,
          ),
        );
      }
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        debugPrint('Response body: $responseBody');
        Get.offNamed(Pages.projectasks);
        tasks.clear();
        Get.snackbar(
          'Success',
          'Upload successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        commentController.value.clear();
        selectedImage.value = null;
        loading.value = false;
      } else if (response.statusCode == 422) {
        loading.value = false;
        Get.snackbar(
          'Update Failed',
          'Image is too large; select an image smaller than 2MB.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        loading.value = false;
        // General error
        Get.snackbar(
          'Error',
          'Failed to upload: ${response.reasonPhrase}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, stackTrace) {
      loading.value = false;
      debugPrint('Error during upload: $e');
      debugPrint('StackTrace: $stackTrace');
      Get.snackbar(
        'Upload Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
