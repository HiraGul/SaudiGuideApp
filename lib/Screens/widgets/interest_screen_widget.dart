import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';

class InterestScreenWidget extends StatelessWidget {
  final String title;
  final VoidCallback closeTap;
  const InterestScreenWidget(
      {Key? key, required this.title, required this.closeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131.sp,
      height: 38.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: const Color(0xFFF3FEFD),
        border: Border.all(width: 1.0, color: Colors.white38),
      ),
      child: SizedBox(
        width: 131.sp,
        height: 26.sp,
        child: Row(
          children: [
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  color: const Color(0xFF202020),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: closeTap,
                child: Icon(
                  Icons.close,
                  color: AppColors.greenColor,
                  size: 20.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
