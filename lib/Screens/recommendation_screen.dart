import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          'Recommendations',
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

class RecommendationContainer extends StatelessWidget {
  const RecommendationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding:
          EdgeInsets.only(left: 21.sp, right: 13.sp, top: 27.sp, bottom: 27.sp),
      // height: 173.sp,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 12.sp,
                color: const Color.fromRGBO(71, 71, 71, 0.1))
          ],
          color: const Color.fromRGBO(244, 252, 252, 1),
          borderRadius: BorderRadius.circular(15.sp)),
      child: Row(
        children: [
          const Icon(Icons.done),
          SizedBox(
            width: 26.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem Ipsum is simply",
                  style: GoogleFonts.cairo(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(8, 43, 52, 1)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                  style: GoogleFonts.cairo(
                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
