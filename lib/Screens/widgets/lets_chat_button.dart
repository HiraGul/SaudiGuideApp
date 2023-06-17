import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/chat_model.dart';
import '../../Utils/colors.dart';
import '../chat_screen/chat_screen.dart';

class LetsChatButton extends StatelessWidget {
  const LetsChatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
      ]),
      height: 70.h,
      child: InkWell(
        onTap: () {
          RecommendationModel.title = '';
          RecommendationModel.recommendedRegion = [];
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return const ChatScreen();
          }));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.sp),
            //color: const Color(0xff299E97),
            color: AppColors.greenColor,
          ),
          child: Center(
            child: Text(
              'Lets Chat',
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
