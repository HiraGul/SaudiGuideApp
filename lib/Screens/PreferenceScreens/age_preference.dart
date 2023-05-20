import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderAndAgeWidget extends StatelessWidget {
  const GenderAndAgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.6.sh,
      width: 1.sw,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [
          SizedBox(
            height: 48.sp,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Gender & Age",
              style: GoogleFonts.cairo(
                fontSize: 27.0.sp,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Text(
              "Please select your gender and age ",
              style: GoogleFonts.cairo(
                fontSize: 16.0.sp,
                color: const Color(0xFF9F9F9F),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            'Gender',
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              color: const Color(0xFF858585),
            ),
          ),
        ],
      ),
    );
  }
}
