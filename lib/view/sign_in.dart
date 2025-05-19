// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tms_mobileapp/view_model.dart/components/build_text_field.dart';
import 'package:tms_mobileapp/utils/color_palette.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';
import 'package:tms_mobileapp/utils/images.dart';
import 'package:tms_mobileapp/view_model.dart/components/widgets.dart';
import '../controllers/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    if (mounted) {
      authController.emailController.value.text;
      authController.passwordController.value.text;
    }
    super.dispose();
  }

  void removeSavedCredentials() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
  }

  // Save credentials securely
  Future<void> _saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  // Load saved credentials
  Future<void> _loadSavedCredentials() async {
    final credentials = await _storage.readAll();
    if (credentials['username'] != null && credentials['password'] != null) {
      authController.emailController.value.text = credentials['username']!;
      authController.passwordController.value.text = credentials['password']!;
      authController.rememberMe.value = true; // Mark as "remember me"
    }
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    Center(
                      child: Image.asset(
                        AppImages.logo,
                        height: 150,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: textXExtraLarge,
                        fontWeight: FontWeight.w500,
                        color: kBlackColor,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            BuildTextField(
                              borderType: 2,
                              hint: 'Email',
                              controller: authController.emailController.value,
                              inputType: TextInputType.emailAddress,
                              obscureText: false,
                              onChange: (value) {},
                            ),
                            BuildTextField(
                              borderType: 2,
                              hint: 'Password',
                              controller:
                                  authController.passwordController.value,
                              inputType: TextInputType.text,
                              obscureText: true,
                              filled: false,
                              onChange: (value) {},
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildText(
                                  'Remember me',
                                  kBlackColor,
                                  textSmall,
                                  FontWeight.w500,
                                  TextAlign.start,
                                  TextOverflow.clip,
                                  0,
                                ),
                                Obx(
                                  () => Checkbox(
                                    splashRadius: 0,
                                    value: authController.rememberMe.value,
                                    onChanged: (bool? value) {
                                      authController.rememberMe.value = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                  top: 100.h,
                                  left: 50,
                                  right: 50,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      // Save credentials if 'Remember me' is true
                                      if (authController.rememberMe.value) {
                                        _saveCredentials(
                                          authController
                                              .emailController.value.text,
                                          authController
                                              .passwordController.value.text,
                                        );
                                      }
                                      authController
                                          .login(); // Call login method in controller
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: kPrimaryColor,
                                    foregroundColor: kWhiteColor,
                                    minimumSize: Size(0.5.sw, 50),
                                  ).copyWith(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    authController.isLoading.value
                                        ? 'Loading'
                                        : "Sign in",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: textMedium,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
