import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  String title;
  String icon;
  final VoidCallback onTap;
  CustomCard(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 282.0.sp,
        height: 90.0.sp,
        margin: EdgeInsets.symmetric(horizontal: 35.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFEFEFEF),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E5E5E).withOpacity(0.1),
              offset: Offset(0, 3.0),
              blurRadius: 12.0,
            ),
          ],
        ),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 10.sp,
            ),
            CircleAvatar(
              radius: 35.sp,
              backgroundColor: const Color(0xffECFFFE),
              child: SvgPicture.string(
                icon,
                width: 38.sp,
                height: 34.1,
              ),
            ),
            SizedBox(
              width: 31.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.sp),
              color: Colors.grey.shade200,
              width: 1.sp,
            ),
            SizedBox(
              width: 26.sp,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 16.0.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
