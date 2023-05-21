import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Utils/colors.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLine,
    required this.taskDate,
  });

  final TextEditingController? controller;
  final String? hintText;

  final int? maxLine;
  final Function(DateTime) taskDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      cursorHeight: 20.sp,
      cursorColor: AppColors.greenColor,
      // autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: maxLine ?? 1,

      style: TextStyle(
        fontSize: 16.sp,
        // height: widget.fieldHeight
      ),
      decoration: InputDecoration(
        errorMaxLines: 1,
        suffixIcon: IconButton(
          onPressed: () async {
            var formatedDate = await getDate(context);
            if (formatedDate != null) {
              controller!.text = formatedDate;
            }
          },
          icon: Icon(
            Icons.calendar_month_outlined,
            color: AppColors.greenColor,
          ),
        ),
        filled: true,
        fillColor: AppColors.textFieldColor,
        errorStyle: TextStyle(
          fontSize: 10.sp,
          height: 0.2.sp,
        ),
        hintStyle: GoogleFonts.openSans(
          fontSize: 16.sp,
        ),
        hintText: hintText,
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
    );
  }

  getDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: AppColors.greenColor,
              )),
              child: child!);
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2026));
    if (pickedDate != null) {
      var formatedDAte = DateFormat("dd/MM/yyyy").format(pickedDate);
      taskDate(pickedDate);

      return formatedDAte;
    }
  }
}
