// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tms_mobileapp/utils/images.dart';
import '../utils/color_palette.dart';
import '../utils/font_sizes.dart';
import 'view_model.dart/components/widgets.dart';
import 'view_model.dart/servcies/splash_services.dart/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices().startTimer();
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
          backgroundColor: kPrimaryColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Image.asset(
                  AppImages.logo,
                  height: 110.h,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildText('Task Managment System', kWhiteColor, textLarge,
                  FontWeight.w500, TextAlign.center, TextOverflow.clip, 1),
              const SizedBox(
                height: 10,
              ),
            ],
          ))),
    );
  }
}
