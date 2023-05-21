import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/strings.dart';

import 'custom_card.dart';

class CardCustomWidget extends StatefulWidget {
  TabController controller;
  CardCustomWidget({required this.controller, Key? key}) : super(key: key);

  @override
  State<CardCustomWidget> createState() => _CardCustomWidgetState();
}

class _CardCustomWidgetState extends State<CardCustomWidget> {
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
                title: "Work",
                icon: AppStrings.worker,
                onTap: () {},
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                title: "Study",
                icon: AppStrings.study,
                onTap: () {},
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                title: "Tourist",
                icon: AppStrings.traveler,
                onTap: () {},
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                title: "Hajj",
                icon: AppStrings.qaaba,
                onTap: () {},
              ),
              SizedBox(
                height: 10.sp,
              ),
              CustomCard(
                title: "Umrah",
                icon: AppStrings.umrah,
                onTap: () {},
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
