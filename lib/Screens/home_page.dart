import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/loginScreen/login_screen.dart';
import 'package:saudi_guide/Utils/colors.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/bc.png',
                    ))),
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstOut),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/shadow.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 138.sp,
            child: Container(
              margin: EdgeInsets.only(left: 15.sp),
              width: 0.92.sw,
              height: 271.0.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0.r),
                  image: const DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'assets/container.png',
                      ))),
              child: ListView(
                padding: EdgeInsets.only(top: 10.sp, left: 20.sp, right: 20.sp),
                children: [
                  Text(
                    'Saudi Guide',
                    style: GoogleFonts.cairo(
                      fontSize: 22.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.sp),
                    child: Text(
                      'SaudiGuide is an advanced and technology-enabled app that combines a range of cutting-edge features using Cohere & Stable Diffusion to provide an exceptional travel experience for visitors exploring the Kingdom of Saudi Arabia.',
                      style: GoogleFonts.cairo(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120.sp,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: Container(
                width: 55.0.sp,
                height: 55.0.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greenColor,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
