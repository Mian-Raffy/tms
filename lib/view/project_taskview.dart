import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import 'package:tms_mobileapp/view/update_screen.dart';
import '../controllers/task_controller.dart';
import '../model/task_model.dart';
import '../utils/color_palette.dart';
import '../view_model.dart/components/widgets.dart';

class ProjectTaskView extends StatefulWidget {
  final TaskModel taskModel;
  final int index;

  const ProjectTaskView(
      {super.key, required this.taskModel, required this.index});

  @override
  State<ProjectTaskView> createState() => _ProjectTaskViewState();
}

class _ProjectTaskViewState extends State<ProjectTaskView> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        taskController.saveTaskName(widget.taskModel.title);
        taskController.saveTaskid(widget.taskModel.id);
        Get.off(() => UpdateTaskScreen());
        taskController.tasks.clear();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shadowColor: kBlackColor,
        elevation: 4.0,
        color: kWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kSecondaryColor,
                radius: 20,
                child: Icon(
                  Icons.task,
                  color: kWhiteColor,
                  size: 18,
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
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attachment,
                                color: kBlackColor,
                                size: 18,
                              ),
                              buildText(
                                ' ${widget.taskModel.attachmentFileCount}',
                                kBlackColor,
                                textSmall,
                                FontWeight.normal,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                0,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.checklist,
                                color: kRed,
                                size: 20,
                              ),
                              buildText(
                                '  ${widget.taskModel.checklistCount}',
                                kBlackColor,
                                textMedium,
                                FontWeight.normal,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                0,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.green.shade700,
                                size: 19,
                              ),
                              buildText(
                                '  ${widget.taskModel.commentCount}',
                                kBlackColor,
                                textMedium,
                                FontWeight.normal,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                0,
                              ),
                            ],
                          ),
                        ],
                      ),
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
