import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';

class MyFormField extends StatefulWidget {
  // final bool? enabled;
  // final bool? isPasswordField;
  final TextEditingController? controller;
  final String? hintText;

  final String? Function(String?)? validator;
  final int? maxLine;
  final TextInputType keyboardType;

  const MyFormField({
    Key? key,
    this.validator,
    required this.controller,
    this.hintText,
    this.maxLine,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            cursorHeight: 20.sp,
            cursorColor: AppColors.greenColor,
            // autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            maxLines: widget.maxLine ?? 1,

            style: TextStyle(
              fontSize: 16.sp,
              // height: widget.fieldHeight
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.sp),
              errorMaxLines: 1,

              filled: true,
              fillColor: AppColors.textFieldColor,
              errorStyle: TextStyle(
                fontSize: 10.sp,
                height: 0.2.sp,
              ),
              hintStyle: GoogleFonts.openSans(
                fontSize: 14.sp,
              ),
              hintText: widget.hintText,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              // disabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4.sp),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4.sp),
              //   borderSide: const BorderSide(
              //     color: Colors.redAccent,
              //     width: 1,
              //   ),
              // ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4.sp),
              //   borderSide: const BorderSide(
              //     color: Colors.red,
              //     width: 1,
              //   ),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4.sp),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(4.sp),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
