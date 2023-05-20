import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Screens/recommendation_screen.dart';
import 'package:saudi_guide/Utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> menuItem = [
    {
      "page": const RecommendationScreen(),
      "title": "Guidance",
      "icon": "assets/icons/guidance.png"
    },
    {
      "page": Container(
        color: Colors.white,
      ),
      "title": "Augmented Reality",
      "icon": "assets/icons/augmented_reality.png"
    },
    {
      "page": Container(
        color: Colors.white,
      ),
      "title": "Realtime Weather",
      "icon": "assets/icons/cloudy.png"
    },
    {
      "page": Container(
        color: Colors.white,
      ),
      "title": "Safety & Security",
      "icon": "assets/icons/shield.png"
    },
    {
      "page": Container(
        color: Colors.white,
      ),
      "title": "Multi language",
      "icon": "assets/icons/language.png"
    },
    {
      "page": Container(
        color: Colors.white,
      ),
      "title": "To do",
      "icon": "assets/icons/todo.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          height: 70.h,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                      //   color: Colors.red,
                      height: 30.sp,
                      width: 30.sp,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset('assets/logo_black.svg')))),
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
                style: GoogleFonts.cairo(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenColor,
                ),
              ),
              Text(
                'Glad to see you here',
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
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
                    onTap: () {
                      print(menuItem[index]['page']);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return menuItem[index]['page'];
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.sp),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(100), blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(20.sp),
                        color: index == 0 ? AppColors.greenColor : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                menuItem[index]['title'],
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w800,
                                  color:
                                      index == 0 ? Colors.white : Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
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
                                    child: SizedBox(
                                        width: 40.sp,
                                        height: 40.sp,
                                        child: Image.asset(
                                          menuItem[index]['icon'],
                                          color: AppColors.greenColor,
                                        )),
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
    );
  }
}
