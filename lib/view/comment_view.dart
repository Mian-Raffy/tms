// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import '../controllers/task_controller.dart';
import '../model/task_model.dart';
import '../utils/color_palette.dart';

class CommentView extends StatefulWidget {
  final TaskModel taskModel;
  int index;
  CommentView({
    super.key,
    required this.index,
    required this.taskModel,
  });

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final TaskController taskController = Get.put(TaskController());

  String getStatusDisplay(String status) {
    switch (status) {
      case 'in_progress':
        return 'in progress';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = widget.taskModel.comments[widget.index];

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.mode_comment,
                size: 20,
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comments.createdBy,
                    style: TextStyle(
                      fontSize: textLarge,
                      fontWeight: FontWeight.bold,
                      color: kBlackColor,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    comments.comment,
                    style: TextStyle(
                      fontSize: textMedium,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
