import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/widgets/weekly_weather_widget.dart';
import 'package:saudi_guide/Utils/colors.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
        ]),
        height: 70.h,
        child: Center(
          child: Container(
            width: 100.sp,
            child: Row(
              children: [
                Container(
                    alignment: const Alignment(0.03, -0.03),
                    width: 37.sp,
                    height: 35.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.sp),
                      color: const Color(0xFFE8F3F3),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.greenColor,
                    )),
                SizedBox(
                  width: 10.sp,
                ),
                Container(
                    alignment: const Alignment(0.03, -0.03),
                    width: 37.sp,
                    height: 35.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.sp),
                      color: const Color(0xFFE8F3F3),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.greenColor,
                    )),
              ],
            ),
          ),
        ),
      ),
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
          'Realtime Weather',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF082B34),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [
          SizedBox(
            height: 20.sp,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Jeddha,KSA',
              style: GoogleFonts.cairo(
                fontSize: 24.sp,
                color: const Color(0xFF082B34),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'It\'s raining Now',
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              color: const Color(0xFF878787),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '22 C',
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              color: const Color(0xFF878787),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 180.sp,
            child: Row(
              children: [
                Expanded(flex: 6, child: Image.asset('assets/icons/rain.png')),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white38,
                      child: Column(
                        children: [
                          Expanded(
                            child: weatherWidget(
                                image: 'assets/icons/humidity.png',
                                title: '54 % &+'),
                          ),
                          Expanded(
                            child: weatherWidget(
                                image: 'assets/icons/wind.png', title: '9mph'),
                          ),
                          Expanded(
                            child: weatherWidget(
                                image: 'assets/icons/sun.png', title: '6:00pm'),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
              padding: EdgeInsets.only(left: 14.sp, right: 19.sp),
              height: 220.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.sp),
                color: const Color(0xFFF4FCFC),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF474747).withOpacity(0.1),
                    offset: const Offset(0, 3.0),
                    blurRadius: 12.sp,
                  ),
                ],
              ),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return const WeeklyWeatherWidget(
                        dayName: 'Monday', time: '9mph', percentage: '54 %');
                  })),
        ],
      ),
    );
  }

  weatherWidget({required String image, required String title}) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(image),
        ),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.greenColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
