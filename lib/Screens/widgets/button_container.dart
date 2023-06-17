import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/colors.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sp),
     //   color: const Color(0xff299E97),
        color: AppColors.greenColor,
      ),
      child: widget,
    );
  }
}
