import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final bool? enable;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.enable = true,
      required this.inputType,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0.sp),
        color: AppColors.textFieldColor,
      ),
      child: TextFormField(
        enabled: enable,
        keyboardType: inputType,
        cursorHeight: 20.sp,
        cursorColor: AppColors.greenColor,
        controller: controller,
        style: TextStyle(
          fontSize: 16.sp,
          // height: widget.fieldHeight
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12.sp),
          filled: true,
          fillColor: AppColors.textFieldColor,
          hintStyle: GoogleFonts.openSans(
            fontSize: 16.sp,
          ),
          hintText: hintText,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
