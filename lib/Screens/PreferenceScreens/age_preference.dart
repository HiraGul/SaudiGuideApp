import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/widgets/custom_text_field.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/prfencess_controller.dart';

class GenderAndAgeWidget extends StatefulWidget {
  const GenderAndAgeWidget({Key? key}) : super(key: key);

  @override
  State<GenderAndAgeWidget> createState() => _GenderAndAgeWidgetState();
}

class _GenderAndAgeWidgetState extends State<GenderAndAgeWidget> {
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            height: 50.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0.sp),
              color: AppColors.textFieldColor,
            ),
            child: DropdownButtonFormField(
              style: GoogleFonts.tajawal(
                fontSize: 14.0.sp,
                color: const Color(0xFF646464),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: GoogleFonts.tajawal(
                  fontSize: 14.0.sp,
                  color: const Color(0xFF646464),
                ),
              ),

              isExpanded: true,
              hint: Text(PreferencesController.genderController.text == ''
                  ? 'Male'
                  : PreferencesController.genderController.text),

              // Down Arrow Icon
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.greenColor,
                size: 20.sp,
              ),

              // Array list of items
              items: <String>['Male', 'Female'].map((String items) {
                return DropdownMenuItem(
                  onTap: () {
                    PreferencesController.genderController.text = items;
                  },
                  value: items,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      items,
                      style: GoogleFonts.tajawal(
                        fontSize: 14.0.sp,
                        color: const Color(0xFF646464),
                      ),
                    ),
                  ),
                );
              }).toList(),

              onChanged: (dynamic val) {},
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            height: 82.sp,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Age',
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF858585),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: PreferencesController.ageController,
                        inputType: TextInputType.number,
                        hintText: '25',
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  width: 20.sp,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Family members',
                          style: GoogleFonts.cairo(
                            fontSize: 15.sp,
                            color: const Color(0xFF858585),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: CustomTextField(
                      controller: PreferencesController.familyController,
                      inputType: TextInputType.number,
                      hintText: '10',
                    )),
                  ],
                )),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            'Monthly Income',
            style: GoogleFonts.cairo(
              fontSize: 15.sp,
              color: const Color(0xFF858585),
            ),
          ),
          CustomTextField(
            controller: PreferencesController.salaryController,
            inputType: TextInputType.number,
            hintText: '50000',
          )
        ],
      ),
    );
  }
}
