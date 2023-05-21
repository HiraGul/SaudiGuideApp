import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/prfencess_controller.dart';
import 'package:saudi_guide/Utils/strings.dart';

import 'custom_card.dart';

class CardCustomWidget extends StatefulWidget {
  TabController controller;
  CardCustomWidget({required this.controller, Key? key}) : super(key: key);

  @override
  State<CardCustomWidget> createState() => _CardCustomWidgetState();
}

class _CardCustomWidgetState extends State<CardCustomWidget> {
  int currentIndex = 0;
  void goToBackTab() {
    widget.controller.animateTo(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 48.sp,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                goToBackTab();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5.sp),
                  width: 31.sp,
                  height: 31.sp,
                  margin: EdgeInsets.only(left: 20.sp),
                  decoration: const BoxDecoration(
                      color: Color(0xffE9E9E9), shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.sp,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Why Saudi",
                style: GoogleFonts.cairo(
                  fontSize: 27.0.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.sp,
        ),
        Text(
          'Why are you visiting Saudi Arabia',
          style: GoogleFonts.cairo(
            fontSize: 16.0.sp,
            color: const Color(0xFF9F9F9F),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.sp,
        ),
        SizedBox(
          height: 280.sp,
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
              CustomCard(
                textColor: currentIndex == 1 ? Colors.white : Colors.black,
                tileColor:
                    currentIndex == 1 ? AppColors.greenColor : Colors.white,
                title: "Work",
                icon: AppStrings.worker,
                onTap: () {
                  currentIndex = 1;
                  setState(() {});
                  PreferencesController.purposeController.text = "Work";
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                textColor: currentIndex == 2 ? Colors.white : Colors.black,
                tileColor:
                    currentIndex == 2 ? AppColors.greenColor : Colors.white,
                title: "Study",
                icon: AppStrings.study,
                onTap: () {
                  currentIndex = 2;
                  setState(() {});
                  PreferencesController.purposeController.text = "Study";
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                textColor: currentIndex == 3 ? Colors.white : Colors.black,
                tileColor:
                    currentIndex == 3 ? AppColors.greenColor : Colors.white,
                title: "Tourist",
                icon: AppStrings.traveler,
                onTap: () {
                  currentIndex = 3;
                  setState(() {
                    PreferencesController.purposeController.text = "Tourist";
                  });
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                textColor: currentIndex == 4 ? Colors.white : Colors.black,
                tileColor:
                    currentIndex == 4 ? AppColors.greenColor : Colors.white,
                title: "Hajj",
                icon: AppStrings.qaaba,
                onTap: () {
                  currentIndex = 4;
                  setState(() {});
                  PreferencesController.purposeController.text = "Hajj";
                },
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                textColor: currentIndex == 5 ? Colors.white : Colors.black,
                tileColor:
                    currentIndex == 5 ? AppColors.greenColor : Colors.white,
                title: "Umrah",
                icon: AppStrings.umrah,
                onTap: () {
                  currentIndex = 5;
                  setState(() {});
                  PreferencesController.purposeController.text = "Umrah";
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.sp,
        ),
      ],
    );
  }
}
