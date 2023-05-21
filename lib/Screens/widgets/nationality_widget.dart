import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/widgets/custom_text_field.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/prfencess_controller.dart';

class NationalityWidget extends StatefulWidget {
  TabController controller;
  NationalityWidget({required this.controller, Key? key}) : super(key: key);

  @override
  State<NationalityWidget> createState() => _NationalityWidgetState();
}

class _NationalityWidgetState extends State<NationalityWidget> {
  void goToBackTab() {
    widget.controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.6.sh,
      width: 1.sw,
      child: ListView(
        children: [
          SizedBox(
            height: 48.sp,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  goToBackTab();
                },
                child: Align(
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
              ),
              SizedBox(
                width: 60.sp,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Nationality",
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
            height: 10.sp,
          ),
          Center(
            child: Text(
              "Please select your nationality\n from the given below ",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.sp),
            child: Text(
              'Country',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                color: const Color(0xFF858585),
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          InkWell(
            onTap: () {
              showCountryPicker(
                context: context,

                favorite: <String>['PK'],

                showPhoneCode: false,
                onSelect: (Country country) {
                  PreferencesController.countryController.text = country.name;
                },
                // Optional. Sets the theme for the country list picker.
                countryListTheme: CountryListThemeData(
                  // Optional. Sets the border radius for the bottomsheet.
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  // Optional. Styles the search field.
                  inputDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                    hintStyle: GoogleFonts.openSans(
                      fontSize: 14.sp,
                    ),
                    labelText: 'Search',
                    hintText: 'Start typing to search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.greenColor,
                    ),
                    labelStyle: GoogleFonts.openSans(
                        color: AppColors.greenColor, fontSize: 14.sp),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                  // Optional. Styles the text in the search field
                  searchTextStyle: TextStyle(
                    color: AppColors.greenColor,
                    fontSize: 18.sp,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 45.sp),
              child: CustomTextField(
                  enable: false,
                  controller: PreferencesController.countryController,
                  inputType: TextInputType.name,
                  hintText: 'Select Country'),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.sp),
            child: Text(
              'Religion',
              style: GoogleFonts.cairo(
                fontSize: 15.sp,
                color: const Color(0xFF858585),
              ),
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 45.sp),
            child: CustomTextField(
                enable: true,
                controller: PreferencesController.religionController,
                inputType: TextInputType.name,
                hintText: 'Islam'),
          ),
          SizedBox(
            height: 20.sp,
          ),
        ],
      ),
    );
  }
}
