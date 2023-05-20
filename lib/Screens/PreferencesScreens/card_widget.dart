import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/strings.dart';

import 'custom_card.dart';

class CardCustomWidget extends StatelessWidget {
  const CardCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 48.sp,
        ),
        Text(
          'SAUDI GUIDE',
          style: GoogleFonts.cairo(
            fontSize: 27.0.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.sp,
        ),
        Text(
          'Please Select the option given below \nto proceed further',
          style: GoogleFonts.cairo(
            fontSize: 16.0.sp,
            color: const Color(0xFF9F9F9F),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 40.sp,
        ),
        CustomCard(
          title: "As Visitor",
          icon: AppStrings.traveler,
        ),
        SizedBox(
          height: 27.sp,
        ),
        CustomCard(
          title: "As Worker",
          icon: AppStrings.worker,
        )
      ],
    );
  }
}
