import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Cubits/my_recomendation_repo/my_recomendation_cubit.dart';
import 'package:saudi_guide/Screens/bottom_navigation_screen/home_screen.dart';
import 'package:saudi_guide/Screens/widgets/button_container.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/cubits/bottom_navigation_cubit.dart';

import '../widgets/lets_chat_button.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController pageController = PageController();

  @override
  void initState() {

    // context.read<MyRecommendationCubit>().getMessage(message: 'I want to perform umrrah');
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // value: SystemUiOverlayStyle(
    //           systemNavigationBarIconBrightness: Brightness.dark,
    //           statusBarColor: Colors.transparent,
    //           statusBarIconBrightness: Brightness.dark,
    //           statusBarBrightness: Brightness.dark,
    return BlocProvider(
      create: (context) => BottomNavigationCubit(0),
      child: Scaffold(
        //bottomNavigationBar: const LetsChatButton(),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
        //     BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
        //   ]),
        //   height: 70.h,
        //   child: Row(
        //     children: [
        //       BottomNavItems(
        //         pageController: pageController,
        //         iconData: Icons.home,
        //         title: "Home",
        //         currentIndex: 0,
        //       ),
        //       BottomNavItems(
        //         pageController: pageController,
        //         iconData: CupertinoIcons.calendar,
        //         title: "Calendar",
        //         currentIndex: 1,
        //       ),
        //       BottomNavItems(
        //         pageController: pageController,
        //         iconData: Icons.search,
        //         title: "Search",
        //         currentIndex: 2,
        //       ),
        //       BottomNavItems(
        //         pageController: pageController,
        //         iconData: Icons.info,
        //         title: "Help",
        //         currentIndex: 3,
        //       ),
        //       BottomNavItems(
        //         pageController: pageController,
        //         iconData: Icons.person,
        //         title: "Profile",
        //         currentIndex: 4,
        //       ),
        //     ],
        //   ),
        // ),
        body: SafeArea(
            child: PageView(
          controller: pageController,
          children: [
            const HomeScreen(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        )),
      ),
    );
  }
}

class BottomNavItems extends StatelessWidget {
  final String title;
  final int currentIndex;
  final IconData iconData;
  final PageController pageController;

  const BottomNavItems({
    Key? key,
    required this.pageController,
    required this.iconData,
    required this.title,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              context
                  .read<BottomNavigationCubit>()
                  .getNext(index: currentIndex);
              pageController.jumpToPage(currentIndex);
            },
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Icon(
                    iconData,
                    size: 30.sp,
                    color: state == currentIndex
                        ? AppColors.greenColor
                        : Colors.grey,
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            child: Text(
                          title,
                          style: GoogleFonts.cairo(
                            color: state == currentIndex
                                ? AppColors.greenColor
                                : Colors.grey,
                            fontSize: 14.sp,
                          ),
                        )),
                        SizedBox(
                          height: 4.sp,
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: state == currentIndex
                                  ? AppColors.greenColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            width: state == currentIndex ? 18.sp : 3.sp,
                            height: 5.sp,
                          ),
                        )),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
