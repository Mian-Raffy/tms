// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/controllers/task_controller.dart';
import 'package:tms_mobileapp/routes/pages.dart';
import 'package:tms_mobileapp/view/project_taskview.dart';
import '../utils/font_sizes.dart';
import '../view_model.dart/components/widgets.dart';
import '../utils/color_palette.dart';

// ignore: must_be_immutable
class SingleProjectScreen extends StatefulWidget {
  const SingleProjectScreen({
    super.key,
  });

  @override
  State<SingleProjectScreen> createState() => _SingleProjectScreenState();
}

class _SingleProjectScreenState extends State<SingleProjectScreen> {
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchTasks();
    });
    super.initState();
  }

  void fetchTasks() {
    if (mounted) {
      taskController.fetchProjecttask(taskController.projectid.toString());
    } else {
      if (kDebugMode) {
        print('no data fetched');
      }
    }
  }

  Future<bool> _onWillPop() async {
    Get.offNamed(Pages.home);
    await Future.delayed(Duration(milliseconds: 500), () {
      taskController.clearModelData();
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: IconButton(
              onPressed: () async {
                Get.offNamed(Pages.home);
                await Future.delayed(Duration(milliseconds: 500), () {
                  taskController.clearModelData();
                });
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: const Text(' Project Tasks'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              buildText(
                'Project Name',
                kBlackColor,
                16,
                FontWeight.bold,
                TextAlign.start,
                TextOverflow.clip,
                .5,
              ),

              SizedBox(height: 10.h),
              SizedBox(
                height: 50,
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 0.09.sw),
                    color: kPrimaryColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: buildText(
                            taskController.ProjectName.value,
                            kWhiteColor,
                            textLarge,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip,
                            0))),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  buildText('Tasks', kBlackColor, 16, FontWeight.bold,
                      TextAlign.start, TextOverflow.clip, .5),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        taskController.fetchProjecttask(
                            taskController.projectid.toString());
                      },
                      icon: Icon(
                        Icons.refresh,
                        size: 16,
                      ))
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              // Obx(() => taskController.tasks.isEmpty
              //     ? Center(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             SizedBox(
              //               height: 0.25.sh,
              //             ),
              //             buildText(
              //                 'Not Found Any  Task',
              //                 kBlackColor,
              //                 18.sp,
              //                 FontWeight.w600,
              //                 TextAlign.center,
              //                 TextOverflow.clip,
              //                 0),
              //           ],
              //         ),
              //       )
              //     : Expanded(
              //         child: ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: taskController.tasks.length,
              //           itemBuilder: (context, index) {
              //             return ProjectTaskView(
              //               taskModel: taskController.tasks[index],
              //               index: index,
              //             );
              //           },
              //         ),
              //       )),
              Obx(() {
                if (taskController.loading.value) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 0.25.sh,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
                if (taskController.hasInternet.value == false) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.25.sh,
                        ),
                        buildText(
                            'No Internet Conection',
                            kBlackColor,
                            16,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip,
                            0),
                      ],
                    ),
                  );
                }
                if (taskController.tasks.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 0.25.sh,
                      ),
                      Center(
                        child: buildText(
                            'No Tasks Found',
                            kBlackColor,
                            16,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip,
                            0),
                      ),
                    ],
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskController.tasks.length,
                      itemBuilder: (context, index) {
                        return ProjectTaskView(
                            taskModel: taskController.tasks[index],
                            index: index);
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
