import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/widgets/lets_chat_button.dart';

import '../Utils/colors.dart';

class SafeAndSecurityScreen extends StatelessWidget {
  const SafeAndSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFBFBFB),
        bottomNavigationBar: const LetsChatButton(),
        appBar: AppBar(
          toolbarHeight: 90.sp,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 5.sp),
              width: 31.sp,
              height: 31.sp,
              margin: EdgeInsets.only(left: 20.sp),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(41, 158, 151, 1),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.sp,
              ),
            ),
          ),
          elevation: 3,
          centerTitle: true,
          title: Text(
            'Safety & Security',
            style: GoogleFonts.cairo(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF082B34),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [
            SizedBox(
              height: 11.sp,
            ),
            Text(
              'Emergency Numbers',
              style: GoogleFonts.cairo(
                  color: AppColors.greenColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Container(
              padding: EdgeInsets.only(left: 14.sp, top: 14.sp),
              height: 130.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.sp),
                  border: Border.all(
                    color: const Color(0xffEFEFEF),
                  )),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Police',
                    style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Makkah, Riyadh and Eastern provinces',
                      value: '911'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'All other provinces of the Kingdom',
                      value: '999'),
                ],
              ),
            ),
            SizedBox(
              height: 11.sp,
            ),
            Container(
              padding: EdgeInsets.only(left: 14.sp, top: 14.sp),
              height: 516.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.sp),
                  border: Border.all(
                    color: const Color(0xffEFEFEF),
                  )),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  safeSecurityRow(policy: 'Tourism Call Center', value: '930'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Car Accidents', value: ': 920000560 (Najm)'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Traffic Police', value: '993'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'General Directorate of Passports', value: '992'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Municipal services', value: '940'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Electricity company emergency', value: '933'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Ministry of Transport emergency', value: '938'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Ministry of Commerce consumer call center',
                      value: '1900'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Ministry of Hajj and Umrah',
                      value: '+966920002814'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Consumer protection', value: '935'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Consumer protection', value: '935'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Consumer protection', value: '935'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Saudi Public Security', value: '989'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Phone Directory', value: '905'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'Emergency medical consultation', value: '937'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(
                      policy: 'General Directorate of Narcotics Control',
                      value: '995'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Saudi Ambulance', value: '997'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Civil Defense', value: '998'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Highway Patrol', value: '996'),
                  SizedBox(
                    height: 5.sp,
                  ),
                  safeSecurityRow(policy: 'Border Guard', value: '994'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  safeSecurityRow({required String policy, required String value}) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.cairo(
          fontSize: 13.sp,
          color: const Color(0xFF5E5E5E),
        ),
        children: [
          TextSpan(
            text: '-  ',
            style: GoogleFonts.cairo(
              fontSize: 12.sp,
              color: const Color(0xFF280146),
            ),
          ),
          TextSpan(
            text: '$policy:',
          ),
          TextSpan(
            text: ' ',
            style: GoogleFonts.cairo(
              color: const Color(0xFF0A0A0A),
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.cairo(
              color: const Color(0xFF0A0A0A),
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: ' ',
            style: GoogleFonts.cairo(
              color: const Color(0xFF0A0A0A),
            ),
          ),
        ],
      ),
    );
  }
}
