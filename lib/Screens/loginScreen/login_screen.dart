import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_guide/Screens/signUpScreen/sign_up_screen.dart';
import 'package:saudi_guide/Utils/colors.dart';

import '../../Repo/auth_repo.dart';
import '../widgets/button_container.dart';
import '../widgets/my_form_field.dart';
import '../widgets/my_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: ListView(
        padding: EdgeInsets.only(top: 110.sp),
        children: [
          SvgPicture.asset(
            'assets/splashLogo.svg',
            fit: BoxFit.contain,
            height: 59.sp,
            width: 131.sp,
          ),
          SizedBox(
            height: 80.sp,
          ),
          Container(
            // height: 655.sp,
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
                    text: 'LOGIN',
                    size: 27.sp,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 78.sp),
                    child: MyText(
                      textAlign: TextAlign.center,
                      text:
                          'Please enter your Email and password to get into the app',
                      size: 16.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 40.sp,
                  ),
                  MyFormField(
                    controller: emailController,
                    hintText: "email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  MyFormField(
                    controller: passController,
                    hintText: "password",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 7.sp,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyText(
                      text: "Forgot Password ?",
                      size: 14.sp,
                      weight: FontWeight.w500,
                      color: AppColors.greenColor,
                      underline: true,
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                  InkWell(
                    onTap: () async {
                      isLoading.value = !isLoading.value;
                      await AuthRepo().signIn(
                        email: emailController.text.trim(),
                        password: passController.text.trim(),
                        context: context,
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
                                  text: 'Login',
                                  size: 18.sp,
                                  weight: FontWeight.w600,
                                  color: Colors.white,
                                );
                              }
                            })),
                  ),
                  SizedBox(
                    height: 80.sp,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(text: 'Don\'t have an account ?', size: 16.sp),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                          },
                          child: MyText(
                            text: 'Sign up',
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
    );
  }
}
