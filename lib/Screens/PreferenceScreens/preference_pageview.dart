import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saudi_guide/Screens/PreferenceScreens/interest_screen.dart';
import 'package:saudi_guide/Screens/PreferencesScreens/card_widget.dart';
import 'package:saudi_guide/Screens/bottom_navigation_screen/bottom_navigtion_screen.dart';
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
  late final TabController controller;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    controller =
        TabController(length: 4, initialIndex: _currentIndex, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void goToNextTab() {
    if (controller.index == 0) {
      controller.animateTo(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (controller.index == 1) {
      controller.animateTo(
        2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (controller.index == 2) {
      controller.animateTo(
        3,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (controller.index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationScreen()));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greenColor,
        body: SafeArea(
            child: Stack(
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
            ListView(children: [
              SizedBox(
                height: 150.sp,
              ),
              Container(
                width: 1.sw,
                height: 560.0.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0.r),
                    topLeft: Radius.circular(20.0.r),
                  ),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: [
                          const GenderAndAgeWidget(),
                          NationalityWidget(
                            controller: controller,
                          ),
                          CardCustomWidget(
                            controller: controller,
                          ),
                          InterestScreen(
                            controller: controller,
                          ),
                        ]),
                    Positioned(
                      bottom: 50.sp,
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
            ]),
          ],
        )));
  }
}
