import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Screens/chat_screen/chat_screen.dart';
import 'package:saudi_guide/Screens/recomended_area.dart';
import 'package:saudi_guide/Screens/widgets/lets_chat_button.dart';
import 'package:saudi_guide/Utils/colors.dart';

import '../Models/recomendation_model.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  void initState() {

    RecommendationModel.title = '';
    RecommendationModel.recommendedRegion = [];
    RecommendationModel.message = '';

    // TODO: implement initState
    super.initState();
  }
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
            decoration:  BoxDecoration(
                color:              AppColors.greenColor,
                 shape: BoxShape.circle),
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

      bottomNavigationBar: const LetsChatButton(),
      body: ListView(
        padding: EdgeInsets.only(top: 60.sp, left: 40.sp, right: 40.sp),
        children: [


          ListView.builder(

            shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: RecommendationData.list.length,
              itemBuilder: (context, index){

            return  InkWell(
              onTap: () {

                RecommendationModel.title = RecommendationData.list[index].title;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecomendedArea(model: RecommendationData.list[index],);
                }));
              },
              child: RecommendationContainer(
                    title: RecommendationData.list[index].title,
                  ),
            );
          }),

          // InkWell(
          //   onTap: (){
          //     RecommendationModel.title = '';
          //     RecommendationModel.recommendedRegion = [];
          //     Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //       return const ChatScreen();
          //     }));
          //   },
          //   child: const RecommendationContainer(
          //     title: 'Others',
          //   ),
          // ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
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
    );
  }
}
