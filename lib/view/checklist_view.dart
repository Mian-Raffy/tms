// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import '../controllers/task_controller.dart';
import '../model/task_model.dart';
import '../utils/color_palette.dart';

class CheckListView extends StatefulWidget {
  final TaskModel taskModel;
  int index;
  CheckListView({super.key, required this.taskModel, required this.index});

  @override
  State<CheckListView> createState() => _CheckListViewState();
}

class _CheckListViewState extends State<CheckListView> {
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    if (widget.taskModel.checklists.isNotEmpty) {
      print('Checklist: ${widget.taskModel.checklists.toString()}');
    } else {
      print('Checklist is null.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkList = widget.taskModel.checklists[widget.index];

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: kGrey3),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(
                  Icons.checklist_rounded,
                  color: kRed,
                  size: 20,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  checkList.name,
                  style: TextStyle(
                    fontSize: textMedium,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }
}
