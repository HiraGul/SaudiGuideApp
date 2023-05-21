import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  final String dayName;
  final String time;
  final String percentage1;
  final String percentage;
  const WeeklyWeatherWidget(
      {Key? key,
      required this.dayName,
      required this.time,
      required this.percentage1,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 66.32.sp,
            height: 26.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       '-',
                //       style: GoogleFonts.cairo(
                //         fontSize: 12.sp,
                //         color: const Color(0xFF280146),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dayName,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        color: const Color(0xFF0A0A0A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            percentage,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.greenColor,
            ),
          ),
        )),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            percentage1,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.greenColor,
            ),
          ),
        )),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            time,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.greenColor,
            ),
          ),
        )),
      ],
    );
  }
}
