import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_guide/Repo/auth_repo.dart';
import 'package:saudi_guide/Utils/colors.dart';

import '../widgets/button_container.dart';
import '../widgets/my_form_field.dart';
import '../widgets/my_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 60.sp,
            child: SvgPicture.asset(
              'assets/splashLogo.svg',
              fit: BoxFit.contain,
              height: 59.sp,
              width: 131.sp,
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: 110.sp),
            children: [
              SizedBox(
                height: 110.sp,
              ),
              Container(
                height: 560.sp,
                padding: EdgeInsets.only(
                    top: 44.sp, left: 20.sp, right: 20.sp, bottom: 50.sp),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.sp),
                        topRight: Radius.circular(40.sp))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyText(
                        text: 'Signup',
                        size: 27.sp,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: MyText(
                          textAlign: TextAlign.center,
                          text:
                              'Please enter your Email and password to get into the app',
                          size: 14.sp,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      MyFormField(
                        controller: nameController,
                        hintText: "Name",
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      MyFormField(
                        controller: emailController,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      MyFormField(
                        controller: passController,
                        hintText: "Password",
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      InkWell(
                        onTap: () async {
                          isLoading.value = !isLoading.value;
                          await AuthRepo().signUp(
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                            context: context,
                            userName: nameController.text.trim(),
                          );
                          isLoading.value = !isLoading.value;
                        },
                        child: ButtonContainer(
                            widget: ValueListenableBuilder(
                                valueListenable: isLoading,
                                builder: (context, value, child) {
                                  if (value) {
                                    return const CircularProgressIndicator(
                                      color: Colors.white,
                                    );
                                  } else {
                                    return MyText(
                                      text: 'Signup',
                                      size: 18.sp,
                                      weight: FontWeight.w600,
                                      color: Colors.white,
                                    );
                                  }
                                })),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                              text: 'Already have an account ?', size: 16.sp),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: MyText(
                                text: ' Login',
                                size: 16.sp,
                                color: AppColors.greenColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
