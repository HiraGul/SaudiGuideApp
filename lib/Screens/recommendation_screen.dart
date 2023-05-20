import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/recomended_area.dart';
import 'package:saudi_guide/Utils/colors.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 251, 251, 1),
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
                color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
        ),
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Recommendations',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            color: const Color(0xFF082B34),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
      //   ]),
      //   height: 70.h,
      //   child: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(4.sp),
      //         color: const Color(0xff299E97),
      //       ),
      //       child: Center(
      //         child: Text(
      //           'Lets Chat',
      //           style: GoogleFonts.cairo(
      //               color: Colors.white,
      //               fontSize: 18.sp,
      //               fontWeight: FontWeight.w500),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.only(top: 60.sp, left: 40.sp, right: 40.sp),
        children: [
          RecommendationContainer(
            title: 'Food & Drinks',
          ),
          SizedBox(
            height: 16.sp,
          ),
          RecommendationContainer(
            title: 'Entertainment',
          ),
          SizedBox(
            height: 16.sp,
          ),
          RecommendationContainer(
            title: 'Tourist',
          ),
          SizedBox(
            height: 16.sp,
          ),
          RecommendationContainer(
            title: 'Hajj',
          ),
          SizedBox(
            height: 16.sp,
          ),
          RecommendationContainer(
            title: 'Umrah',
          ),
        ],
      ),
    );
  }
}

class RecommendationContainer extends StatelessWidget {
  const RecommendationContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RecomendedArea();
        }));
      },
      child: Container(
        alignment: const Alignment(0.01, -0.06),
        width: 282.sp,
        height: 66.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.sp),
          color: Colors.white,
          border: Border.all(
            width: 1.sp,
            color: const Color(0xFFEFEFEF),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E5E5E).withOpacity(0.1),
              offset: const Offset(0, 3.0),
              blurRadius: 12.sp,
            ),
          ],
        ),
        child: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            color: AppColors.greenColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
