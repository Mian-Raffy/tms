import 'package:get/get.dart';

import '../../model/task_model.dart';
import '../data/network/baseApiServices.dart';
import '../data/network/network_api_services.dart';

class TaskRepository {
  bool isupdate = false;
  TaskModel? taskModel;
  final apiServices = NetworkApiServices();

  ///Fetch Projects:
  Future<List<TaskModel>> fetchProject() async {
    dynamic response =
        await apiServices.getRequest(BaseApiservices.fetchProject);
    var taskList = response['message']['projects'] as List? ?? [];
    return taskList.map((task) => TaskModel.fromJson(task)).toList();
  }

  ///Fetch task of Project:

  Future<List<TaskModel>> fetchProjectTaskApi(String id) async {
    dynamic response =
        await apiServices.getRequest(BaseApiservices.fetchProjecttask + id);
    var projects = response['message']['projects'] as List? ?? [];
    var allProjects = <TaskModel>[];
    for (var project in projects) {
      var tasks = project['tasks'] as List? ?? [];
      for (var task in tasks) {
        TaskModel taskModel = TaskModel.fromJson(task);
        allProjects.add(taskModel);
      }
    }
    return allProjects;
  }

  ///Fetch Only Task DaTA:
  Future<List<TaskModel>> fetchTaskData(String id) async {
    try {
      dynamic response =
          await apiServices.getRequest(BaseApiservices.fetchtaskData + id);
      if (response == null ||
          response['message'] == null ||
          response['message']['task'] == null) {
        throw Exception("Invalid response format");
      }
      var task = response['message']['task'] as Map<String, dynamic>? ?? {};
      var allTasks = <TaskModel>[];
      TaskModel taskModel = await processTask(task);
      allTasks.add(taskModel);
      return allTasks;
    } catch (e) {
      print("Error fetching task data: $e");
      return [];
    }
  }

  Future<TaskModel> processTask(Map<String, dynamic> task) async {
    var taskFiles = task['task_files'] as List? ?? [];
    var comments = task['comments'] as List? ?? [];
    var checklist = task['checklist'] as List? ?? [];

    TaskModel taskModel = TaskModel.fromJson(task);
    List<AttachmentModel> attachmentList =
        taskFiles.map((file) => AttachmentModel.fromJson(file)).toList();
    List<CommentModel> commentList =
        comments.map((comment) => CommentModel.fromJson(comment)).toList();
    List<ChecklistModel> checklistList =
        checklist.map((item) => ChecklistModel.fromJson(item)).toList();
    taskModel.attachments.assignAll(attachmentList);
    taskModel.comments.assignAll(commentList);
    taskModel.checklists.assignAll(checklistList);
    return taskModel;
  }
}
