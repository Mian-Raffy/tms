import 'package:get/get.dart';

class TaskModel {
  final String id;
  final String title;
  final String descriptions;
  var createdBy;
  final String? status;
  final String? meterNo;
  final String? subscriptionNo;
  final String? taskType;
  final String? faultDetails;
  final String? areaName;
  int? attachmentFileCount;
  int? commentCount;
  int? checklistCount;
  RxList<AttachmentModel> attachments;
  RxList<CommentModel> comments;
  RxList<ChecklistModel> checklists;

  TaskModel({
    required this.id,
    required this.title,
    required this.descriptions,
    this.createdBy,
    this.status,
    this.meterNo,
    this.subscriptionNo,
    this.taskType,
    this.faultDetails,
    this.areaName,
    this.attachmentFileCount,
    this.commentCount,
    this.checklistCount,
    required this.attachments,
    required this.comments,
    required this.checklists,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "descriptions": descriptions,
      "created_by": createdBy,
      "status": status,
      "meter_no": meterNo,
      "subscription_no": subscriptionNo,
      "task_type": taskType,
      "fault_details": faultDetails,
      "area_name": areaName,
      "attachmentFileCount": attachmentFileCount,
      "commentCount": commentCount,
      "checklistCount": checklistCount,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"]?.toString() ?? '', // Ensure id is always a String
      title: json["title"] ?? 'no name',
      descriptions: json["description"] ?? '',
      createdBy: json["created_by"] ?? '',
      status: json["status"]?.toString(), // Ensure status is a String
      meterNo: json["meter_no"]?.toString(),
      subscriptionNo: json["subscription_no"]?.toString(),
      taskType: json["task_type"]?.toString(),
      faultDetails: json["fault_details"]?.toString(),
      areaName: json["area_name"]?.toString(),
      attachmentFileCount: json["task_files"]?.length ?? 0,
      commentCount: json["comments"]?.length ?? 0,
      checklistCount: json["checklist"]?.length ?? 0,
      attachments: <AttachmentModel>[].obs,
      comments: (json["comments"] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromJson(comment))
              .toList()
              .obs ??
          <CommentModel>[].obs,
      checklists: (json["checklist"] as List<dynamic>?)
              ?.map((checklist) => ChecklistModel.fromJson(checklist))
              .toList()
              .obs ??
          <ChecklistModel>[].obs,
    );
  }
}

class AttachmentModel {
  final int id;
  final String file;
  final String name;
  final String extension;
  final String fileSize;
  final String userType;
  final int createdBy;
  final String createdAt;
  final String updatedAt;

  AttachmentModel({
    required this.id,
    required this.file,
    required this.name,
    required this.extension,
    required this.fileSize,
    required this.userType,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'],
      file: json['file'],
      name: json['name'],
      extension: json['extension'],
      fileSize: json['file_size'],
      userType: json['user_type'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class CommentModel {
  final int id;
  final String comment;
  final String taskId;
  final String createdBy;

  CommentModel({
    required this.id,
    required this.comment,
    required this.taskId,
    required this.createdBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? 0,
      comment: json['comment'] ?? '',
      taskId: json['task_id']?.toString() ?? '',
      createdBy: json["created_by_name"] ?? 'k',
    );
  }
}

class ChecklistModel {
  final int id;
  final int taskId;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;

  ChecklistModel({
    required this.id,
    required this.taskId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id'] ?? 0,
      taskId: json['task_id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
