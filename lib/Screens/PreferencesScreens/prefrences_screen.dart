// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:saudi_guide/Utils/colors.dart';
//
// import 'card_widget.dart';
//
// class PreferencesScreens extends StatelessWidget {
//   const PreferencesScreens({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greenColor,
//       body: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.only(top: 50.sp),
//           children: [
//             SvgPicture.asset(
//               'assets/splashLogo.svg',
//               fit: BoxFit.contain,
//               height: 59.sp,
//               width: 131.sp,
//             ),
//             SizedBox(
//               height: 50.sp,
//             ),
//             Container(
//               width: 414.0.sp,
//               height: 655.0.sp,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40.0),
//                 color: Colors.white,
//               ),
//               child: CardCustomWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
