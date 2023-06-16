import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';

enum UserType { chatBot, user }

class ChatCard extends StatelessWidget {
  final UserType userType;
  final String userName;
  final String message;
  const ChatCard({Key? key, required this.message, required this.userName,required this.userType,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.sp,
        vertical: 11.sp,
      ),
      child:    Align(
        alignment: userType ==UserType.chatBot ? Alignment.centerLeft :Alignment.centerRight ,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 0.8.sw,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.greenColor.withAlpha(50),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(10.sp),
            color: Colors.white,
          ),
          child: RichText(
            text: TextSpan(
              text: "$userName\n",
              style: GoogleFonts.cairo(
                fontSize: 12.sp,
                color: AppColors.greenColor,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: message,
                  style: GoogleFonts.cairo(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
