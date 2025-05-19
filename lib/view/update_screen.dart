// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_mobileapp/controllers/task_controller.dart';
import 'package:tms_mobileapp/model/task_model.dart';
import 'package:tms_mobileapp/routes/pages.dart';
import 'package:tms_mobileapp/view/checklist_view.dart';
import 'package:tms_mobileapp/view/comment_view.dart';
import '../utils/font_sizes.dart';
import '../view_model.dart/components/build_text_field.dart';
import '../view_model.dart/components/custom_dropdown.dart';
import '../view_model.dart/components/widgets.dart';
import '../utils/color_palette.dart';
import 'attachment_view.dart';

class UpdateTaskScreen extends StatefulWidget {
  // final TaskModel? taskModel;

  const UpdateTaskScreen({
    super.key,
  });

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  void fetchTaskData() {
    if (mounted) {
      taskController.fetchProjectTaskData(taskController.taskid.toString());
    } else {
      print('nothing fetch');
    }
  }

  Future<bool> _onWillPop() async {
    backnavigation.value = true;
    taskController.selectedImage.value = null;
    Get.offNamed(Pages.projectasks);
    taskController.clearModelData();

    return false;
  }

  String _formatTaskType(String? areaName) {
    if (areaName == null || areaName.isEmpty) {
      return '--'; // Fallback for null or empty values
    }
    return areaName.replaceAll('_', ' ');
  }

  RxBool backnavigation = false.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: kWhiteColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  backnavigation.value = true;
                  taskController.selectedImage.value = null;
                  Get.offNamed(Pages.projectasks);
                  // taskController.clearModelData();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              scrolledUnderElevation: 0,
              elevation: 0,
              backgroundColor: kWhiteColor,
              centerTitle: true,
              title: const Text('Update Task'),
            ),
            body: Obx(
              () => backnavigation.value == false
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            buildText(
                                'Project Name',
                                kBlackColor,
                                textMedium,
                                FontWeight.bold,
                                TextAlign.start,
                                TextOverflow.clip,
                                0),
                            const SizedBox(height: 10),
                            Card(
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              color: kPrimaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                height: 45.h,
                                child: Center(
                                  child: buildText(
                                    taskController.TasktName.toString(),
                                    kWhiteColor,
                                    textLarge,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Obx(() {
                              final taskModel = taskController.tasks.isNotEmpty
                                  ? taskController.tasks.first
                                  : null;

                              if (taskModel == null) {
                                return SizedBox.shrink();
                              }

                              return CustomDropdown(
                                hint: 'Details',
                                items: [
                                  DropdownMenuItem(
                                    value: "Option 1",
                                    child: Text(
                                        "Description: ${taskModel.descriptions.isNotEmpty ? taskModel.descriptions : '--'}"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Option 2",
                                    child: Row(
                                      children: [
                                        const Text('Meter no:'),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          taskModel.meterNo ?? '--',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Option 3",
                                    child: Row(
                                      children: [
                                        const Text('Subscription no:'),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          taskModel.subscriptionNo ?? '--',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Option 4",
                                    child: Row(
                                      children: [
                                        const Text('Task type:'),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          _formatTaskType(taskModel.taskType),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Option 5",
                                    child: Row(
                                      children: [
                                        const Text('Area name:'),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          taskModel.areaName ?? '--',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  print('Selected: $value');
                                },
                              );
                            }),
                            SizedBox(height: 10.h),
                            buildText(
                                'CheckList',
                                kBlackColor,
                                textMedium,
                                FontWeight.bold,
                                TextAlign.start,
                                TextOverflow.clip,
                                0),
                            SizedBox(height: 8.h),
                            Obx(() {
                              if (taskController.tasks.isEmpty) {
                                return SizedBox.shrink();
                              } else if (taskController
                                  .tasks.first.checklists.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: taskController
                                      .tasks.first.checklists.length,
                                  itemBuilder: (context, index) {
                                    return CheckListView(
                                      taskModel: taskController.tasks.first,
                                      index: index,
                                    );
                                  },
                                );
                              } else if (taskController
                                  .tasks.first.checklists.isEmpty) {
                                return Center(
                                  child: buildText(
                                    'No checklist available',
                                    kBlackColor,
                                    12,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    0,
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }),
                            SizedBox(height: 10.h),
                            Obx(() {
                              if (taskController.selectedImage.value != null) {
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 6,
                                      color: kWhiteColor,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 100.w),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.file(
                                        taskController.selectedImage.value!,
                                        fit: BoxFit.contain,
                                        height: 100.h,
                                        width: 100.h,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Attachments:',
                                    style: TextStyle(
                                        fontSize: textMedium,
                                        fontWeight: FontWeight.w700,
                                        color: kBlackColor)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: kBlackColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 1.h),
                                    side: BorderSide(
                                        color: kBlackColor, width: 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onPressed: () {
                                    taskController.pickImage(
                                        source: ImageSource.gallery);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add,
                                          color: kBlackColor, size: 14),
                                      Text('Add',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Obx(() {
                              if (taskController.tasks.isEmpty) {
                                return Center(child: SizedBox.shrink());
                              } else if (taskController
                                  .tasks.first.attachments.isNotEmpty) {
                                // Attachments available
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: taskController
                                      .tasks.first.attachments.length,
                                  itemBuilder: (context, index) {
                                    return AttachmentView(
                                      taskModel: taskController.tasks.first,
                                      index: index,
                                    );
                                  },
                                );
                              } else if (taskController
                                  .tasks.first.attachments.isEmpty) {
                                return Center(
                                  child: buildText(
                                    'No attachments available',
                                    kBlackColor,
                                    12,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    0,
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }),
                            SizedBox(height: 10.h),
                            buildText(
                                'Add Comment',
                                kBlackColor,
                                textMedium,
                                FontWeight.bold,
                                TextAlign.start,
                                TextOverflow.clip,
                                0),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: BuildTextField(
                                borderType: 1,
                                borderColor: kGrey3,
                                prefixIcon: const Icon(Icons.comment,
                                    color: Colors.green, size: 20),
                                controller:
                                    taskController.commentController.value,
                                hint: '  Add the Comment',
                                hinttextSize: 16,
                                inputType: TextInputType.emailAddress,
                                onChange: (value) => taskController
                                    .commentController.value = value,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            buildText(
                                'Comments',
                                kBlackColor,
                                textMedium,
                                FontWeight.bold,
                                TextAlign.start,
                                TextOverflow.clip,
                                0),
                            SizedBox(height: 8.h),
                            Obx(() {
                              if (taskController.tasks.isEmpty) {
                                return SizedBox.shrink();
                              } else if (taskController
                                  .tasks.first.comments.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: taskController
                                      .tasks.first.comments.length,
                                  itemBuilder: (context, index) {
                                    return CommentView(
                                      taskModel: taskController.tasks.first,
                                      index: index,
                                    );
                                  },
                                );
                              } else if (taskController
                                  .tasks.first.comments.isEmpty) {
                                return Center(
                                  child: buildText(
                                    'No comments available',
                                    kBlackColor,
                                    12,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    0,
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 50.h)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                onPressed: () {
                                  taskController.uploadImageAsStream(
                                      taskController.taskid.toString());
                                },
                                child: buildText(
                                    taskController.loading.value == true
                                        ? 'loading'
                                        : 'Update',
                                    kWhiteColor,
                                    textMedium,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip,
                                    0),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            )));
  }
}
