// ignore_for_file: unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/controllers/auth_controller.dart';
import 'package:tms_mobileapp/controllers/task_controller.dart';
import 'package:tms_mobileapp/utils/color_palette.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import 'package:tms_mobileapp/utils/images.dart';
import 'package:tms_mobileapp/view_model.dart/components/widgets.dart';
import 'package:tms_mobileapp/view_model.dart/servcies/local_storage_services/local_storage_methods_services.dart';

import '../view_model.dart/servcies/greeting_services/greeting_services.dart';
import 'project_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final taskController = TaskController();

  final Greeting greeting = Greeting();

  @override
  void initState() {
    taskController.fetchProject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText('Hello!', kGrey1, 15, FontWeight.w500,
                              TextAlign.start, TextOverflow.clip, 0),
                          buildText(
                              '${LocalStorageMethods.instance.getUsername()}',
                              kBlackColor,
                              15,
                              FontWeight.w700,
                              TextAlign.start,
                              TextOverflow.clip,
                              0),
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        AppImages.logo,
                        height: 40.h,
                      )
                    ],
                  ),
                  Divider(
                    height: 10.h,
                    color: kGrey0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      color: kPrimaryColor,
                      margin: EdgeInsets.symmetric(vertical: 9.h),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.0.w, right: 10.0.w, top: 5.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: buildText(
                                      '${greeting.getGreeting()} 😊',
                                      kWhiteColor,
                                      textLarge.r,
                                      FontWeight.w600,
                                      TextAlign.start,
                                      TextOverflow.clip,
                                      0),
                                ),
                                Spacer(),
                                PopupMenuButton<String>(
                                  surfaceTintColor: kWhiteColor,
                                  padding: EdgeInsets.zero,
                                  menuPadding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 24.r,
                                  ),
                                  onSelected: (value) {
                                    authController.logout(context);
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem<String>(
                                      value: 'logout',
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0.w, top: 22),
                                  child: Text(
                                    'Manage your\nall projects here',
                                    style: TextStyle(
                                        fontSize: textMedium.r,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 100.r,
                                  height: 30.h,
                                  margin:
                                      EdgeInsets.only(right: 10.w, top: 20.h),
                                  decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      'View Projects',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.r,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      buildText(
                          'Projects List',
                          kBlackColor,
                          textLarge,
                          FontWeight.bold,
                          TextAlign.start,
                          TextOverflow.clip,
                          0),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            taskController.fetchProject();
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 20,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
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
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 0.2.sh,
                            ),
                            buildText(
                              'All Your Projects',
                              kBlackColor,
                              25,
                              FontWeight.w600,
                              TextAlign.center,
                              TextOverflow.clip,
                              0,
                            ),
                            buildText(
                              'Manage your task schedule easily\nand efficiently',
                              kBlackColor.withOpacity(.5),
                              15,
                              FontWeight.normal,
                              TextAlign.center,
                              TextOverflow.clip,
                              0,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: taskController.tasks.length,
                          itemBuilder: (context, index) {
                            final task = taskController.tasks[index];
                            return ProjectView(
                              taskModel: task,
                              index: index,
                            );
                          },
                        ),
                      );
                    }
                  })
                ],
              )),
        ),
      ),
    );
  }
}
