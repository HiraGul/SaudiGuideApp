import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

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
          color: const Color(0xff299E97),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 8.sp,
                color: const Color(0xff52a7bd26))
          ]),
      child: widget,
    );
  }
}
