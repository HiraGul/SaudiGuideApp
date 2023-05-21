import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_guide/Screens/PreferencesScreens/card_widget.dart';
import 'package:saudi_guide/Screens/widgets/nationality_widget.dart';
import 'package:saudi_guide/Utils/colors.dart';

import 'age_preference.dart';

class UserPreferenceScreen extends StatefulWidget {
  const UserPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<UserPreferenceScreen> createState() => _UserPreferenceScreenState();
}

class _UserPreferenceScreenState extends State<UserPreferenceScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> widgets = const [
    GenderAndAgeWidget(),
    NationalityWidget(),
    CardCustomWidget(),
  ];
  late final TabController controller;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    controller =
        TabController(length: 3, initialIndex: _currentIndex, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void goToNextTab() {
    if (_currentIndex < controller.length - 1) {
      _currentIndex++;
      controller.animateTo(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void goToBackTab() {
    if (_currentIndex > 0) {
      _currentIndex--;
      controller.animateTo(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greenColor,
        body: SafeArea(
            child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
              SizedBox(
                height: 50.sp,
              ),
              SvgPicture.asset(
                'assets/splashLogo.svg',
                fit: BoxFit.contain,
                height: 59.sp,
                width: 131.sp,
              ),
              SizedBox(
                height: 50.sp,
              ),
              Container(
                width: 1.sw,
                height: 655.0.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: widgets),
                    Positioned(
                      bottom: 150.sp,
                      left: 30.sp,
                      right: 30.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TabPageSelector(
                              color: Colors.grey.shade100,
                              selectedColor: AppColors.greenColor,
                              controller: controller,
                              borderStyle: BorderStyle.solid),
                          InkWell(
                            onTap: () {
                              goToNextTab();
                            },
                            child: Container(
                              width: 34.0.sp,
                              height: 30.0.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0.r),
                                color: AppColors.greenColor,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     goToBackTab();
                          //   },
                          //   child: Container(
                          //     width: 34.0.sp,
                          //     height: 30.0.sp,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(4.0.r),
                          //       color: AppColors.greenColor,
                          //     ),
                          //     child: Icon(
                          //       Icons.arrow_back_ios,
                          //       color: Colors.white,
                          //       size: 20.sp,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
