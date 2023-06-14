import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Models/user_data.dart';
import 'package:saudi_guide/Screens/widgets/interest_screen_widget.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/prfencess_controller.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';

class InterestScreen extends StatefulWidget {
  TabController controller;

  InterestScreen({required this.controller, Key? key}) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  void initState() {
    // UserData userData = UserData(
    //     PreferencesController.countryController.text,
    //     PreferencesController.genderController.text,
    //     PreferencesController.salaryController.text,
    //     PreferencesController.countryController.text,
    //     PreferencesController.purposeController.text,
    //     PreferencesController.ageController.text,
    //     'Riyadh');

    UserData userData = UserData(
      userAge: PreferencesController.ageController.text,
      gender: PreferencesController.genderController.text,
      userLocation: PreferencesController.countryController.text,
      monthlyIncome: PreferencesController.salaryController.text,
      nationality: PreferencesController.countryController.text,
      country: PreferencesController.countryController.text,
      purpose: PreferencesController.purposeController.text,
    );
    MySharedPrefs.setUseData(userData);

    super.initState();
  }

  void goToBackTab() {
    widget.controller.animateTo(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),

      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 48.sp,
        ),
        Stack(
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
            'Please add the required\n Information ',
            style: GoogleFonts.cairo(
              fontSize: 16.0.sp,
              color: const Color(0xFF9F9F9F),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30.sp,
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
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 51.sp, ),
                child: Container(
                  height: 45.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0.sp),
                    color: AppColors.textFieldColor,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorHeight: 20.sp,
                    cursorColor: AppColors.greenColor,
                    controller: PreferencesController.interestController,
                    style: TextStyle(
                      fontSize: 16.sp,
                      // height: widget.fieldHeight
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12.sp),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 14.sp,
                      ),
                      hintText: 'Please select',
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    onFieldSubmitted: (val) {
                      PreferencesController.interest
                          .add(PreferencesController.interestController.text);
                      PreferencesController.interestController.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),

                InkWell(
                  onTap: (){
                    PreferencesController.interest
                        .add(PreferencesController.interestController.text);
                    PreferencesController.interestController.clear();
                    setState(() {});
                  },
                  child: Container(
                    height: 45.sp,
                    width: 40.sp,

                    margin: EdgeInsets.only(left: 5.sp,right: 30.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0.r),
                      color: AppColors.greenColor,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                )

            
          ],
        ),
        SizedBox(
          height: 30.sp,
        ),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 10 / 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10),
            itemCount: PreferencesController.interest.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Wrap(
                  children: [
                    InterestScreenWidget(
                        title: PreferencesController.interest[index],
                        closeTap: () {
                          if (PreferencesController.interest.isNotEmpty) {
                            PreferencesController.interest.removeAt(index);
                            setState(() {});
                          }
                        }),
                  ],
                ),
              );
            }),
        SizedBox(
          height: 60.sp,
        ),
      ],
    );
  }
}
