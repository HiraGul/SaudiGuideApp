import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Utils/colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> menuItem = [
    {
      "page": Container(),
      "title": "Recommendation",
      "icon": "assets/icons/recomendation.png"
    },
    {
      "page": Container(),
      "title": "Augmented Reality",
      "icon": "assets/icons/augmented_reality.png"
    },
    {
      "page": Container(),
      "title": "Realtime Weather",
      "icon": "assets/icons/realtime_weather.png"
    },
    {
      "page": Container(),
      "title": "Safety & Security",
      "icon": "assets/icons/safety_security.png"
    },
    {
      "page": Container(),
      "title": "Multi language",
      "icon": "assets/icons/language.png"
    },
    {"page": Container(), "title": "To do", "icon": "assets/icons/todo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            height: 70.h,
            color: Colors.white,
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text('JMM'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 40.sp,
                            width: 40.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withAlpha(100),
                                      blurRadius: 10)
                                ]),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.bell,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40.sp,
                            width: 40.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(100),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.settings,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Hello John Doe!',
                  style: GoogleFonts.raleway(
                    fontSize: 30.sp,
                    color: AppColors.greenColor,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Glad to see you here',
                  style: GoogleFonts.raleway(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GridView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10.sp,
                    crossAxisSpacing: 10.sp,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(left: 10.sp),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withAlpha(100),
                                blurRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(20.sp),
                          color:
                              index == 0 ? AppColors.greenColor : Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  menuItem[index]['title'],
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w600,
                                      color: index == 0
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 1.sw,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.lightGreen),
                                    child: Center(
                                      child:
                                          Image.asset(menuItem[index]['icon'],color:  AppColors.greenColor,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
