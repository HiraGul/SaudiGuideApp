import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/recommendation_screen.dart';

class SafetySecurityScreen extends StatefulWidget {
  const SafetySecurityScreen({super.key});

  @override
  State<SafetySecurityScreen> createState() => _SafetySecurityScreenState();
}

class _SafetySecurityScreenState extends State<SafetySecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 5.sp),
          width: 31.sp,
          height: 31.sp,
          margin: EdgeInsets.only(left: 20.sp),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
          ),
        ),
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Safety & Security',
          style: GoogleFonts.cairo(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(8, 43, 52, 1)),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 27.sp),
        itemBuilder: (context, index) {
          return const RecommendationContainer();
        },
      ),
    );
  }
}
