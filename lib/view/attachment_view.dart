// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../model/task_model.dart';
import '../utils/color_palette.dart';
import '../view_model.dart/data/network/baseApiServices.dart';

class AttachmentView extends StatefulWidget {
  final TaskModel taskModel;
  int index;

  AttachmentView({super.key, required this.taskModel, required this.index});

  @override
  State<AttachmentView> createState() => _AttachmentViewState();
}

class _AttachmentViewState extends State<AttachmentView> {
  @override
  void initState() {
    print('Path:${widget.taskModel.attachments}');
    super.initState();
  }

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
    final attachment = widget.taskModel.attachments[widget.index];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: kGrey3)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 7.h),
            child: Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${BaseApiservices.imgurl}${attachment.file}',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.delete,
                  color: kRed,
                  size: 20,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
