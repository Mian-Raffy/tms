import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/routes/app_router.dart';

import 'routes/pages.dart';
import 'view_model.dart/servcies/local_storage_services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: Pages.splashScreen,
          onGenerateRoute: onGenerateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Responsive App',
          theme: ThemeData(primarySwatch: Colors.blue),
        );
      },
    );
  }
}
