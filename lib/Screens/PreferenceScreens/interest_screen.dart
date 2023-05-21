import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/widgets/custom_text_field.dart';
import 'package:saudi_guide/Screens/widgets/interest_screen_widget.dart';
import 'package:saudi_guide/Utils/prfencess_controller.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({Key? key}) : super(key: key);

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
            Align(
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
            SizedBox(
              width: 74.sp,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Interest",
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
        Align(
          alignment: Alignment.center,
          child: Text(
            'Please add the required\n Inforamtion ',
            style: GoogleFonts.cairo(
              fontSize: 16.0.sp,
              color: const Color(0xFF9F9F9F),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 40.sp,
        ),
        Container(
          padding: EdgeInsets.only(left: 51.sp, right: 65.sp),
          child: Text(
            'Area of Interest',
            style: GoogleFonts.cairo(
              fontSize: 15.0,
              color: const Color(0xFF858585),
            ),
          ),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Container(
          padding: EdgeInsets.only(left: 51.sp, right: 65.sp),
          child: CustomTextField(
              controller: PreferencesController.interestController,
              inputType: TextInputType.name,
              hintText: 'Type and Select'),
        ),
        SizedBox(
          height: 30.sp,
        ),
        Container(
          padding: EdgeInsets.only(left: 51.sp, right: 65.sp),
          child: Wrap(
            children: [
              InterestScreenWidget(title: 'History', closeTap: () {}),
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
