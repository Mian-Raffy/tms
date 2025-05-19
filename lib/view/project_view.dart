// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import 'package:tms_mobileapp/view/single_project.dart';
import '../controllers/task_controller.dart';
import '../model/task_model.dart';
import '../utils/color_palette.dart';
import '../view_model.dart/components/widgets.dart';

class ProjectView extends StatefulWidget {
  final TaskModel taskModel;
  final int index;

  const ProjectView({super.key, required this.taskModel, required this.index});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
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
    return InkWell(
      onTap: () {
        taskController.saveProjectId(widget.taskModel.id);
        taskController.saveProjectName(widget.taskModel.title);
        Get.to(() => SingleProjectScreen());
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shadowColor: kBlackColor,
        elevation: 3.0,
        color: kWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kSecondaryColor,
                radius: 18,
                child: Icon(
                  Icons.work_outline_rounded,
                  color: kWhiteColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      widget.taskModel.title,
                      kBlackColor,
                      textLarge,
                      FontWeight.bold,
                      TextAlign.start,
                      TextOverflow.ellipsis,
                      0,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: kBlackColor,
                          size: 20,
                        ),
                        buildText(
                          '  ${widget.taskModel.createdBy}',
                          kBlackColor,
                          12.r,
                          FontWeight.normal,
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          0.2,
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 4.r, horizontal: 8.r),
                          child: buildText(
                            getStatusDisplay(
                                widget.taskModel.status.toString()),
                            Colors.green,
                            textMedium.r,
                            FontWeight.bold,
                            TextAlign.end,
                            TextOverflow.ellipsis,
                            0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
