import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/recomendation_model.dart';
import 'package:saudi_guide/Screens/chat_screen/chat_screen.dart';
import 'package:saudi_guide/Utils/colors.dart';

class RecomendedArea extends StatefulWidget {
  final RecommendationDataModel model;

  const RecomendedArea({Key? key, required this.model}) : super(key: key);

  @override
  State<RecomendedArea> createState() => _RecomendedAreaState();
}

class _RecomendedAreaState extends State<RecomendedArea> {
  @override
  void initState() {
    RecommendationModel.recommendedRegion = [];
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
            decoration: const BoxDecoration(
              color: Color.fromRGBO(41, 158, 151, 1),
              shape: BoxShape.circle,
            ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 5,
          )
        ]),
        height: 70.h,
        child: InkWell(
          onTap: () {
            if (RecommendationModel.title == 'Hajj' ||
                RecommendationModel.title == 'Umrah') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ChatScreen();
              }));
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ChatScreen(
                  isRecommendedOption: true,
                );
              }));
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: const Color(0xff299E97),
            ),
            child: Center(
              child: Text(
                'Proceed',
                style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.model.subCategories.length,
          padding: EdgeInsets.only(top: 60.sp, left: 40.sp, right: 40.sp),
          itemBuilder: (context, index) {
            return RecommendationCheckArea(
              title: widget.model.subCategories[index],
            );
          }),
      // body: ListView(
      //   shrinkWrap: true,
      //   padding: EdgeInsets.only(top: 60.sp, left: 40.sp, right: 40.sp),
      //   children: [
      //     RecommendationCheckArea(
      //       title: 'Food & Drinks',
      //     ),
      //     SizedBox(
      //       height: 16.sp,
      //     ),
      //     RecommendationCheckArea(
      //       title: 'Entertainment',
      //     ),
      //     SizedBox(
      //       height: 16.sp,
      //     ),
      //     RecommendationCheckArea(
      //       title: 'Tourist',
      //     ),
      //     SizedBox(
      //       height: 16.sp,
      //     ),
      //     RecommendationCheckArea(
      //       title: 'Hajj',
      //     ),
      //     SizedBox(
      //       height: 16.sp,
      //     ),
      //     RecommendationCheckArea(
      //       title: 'Umrah',
      //     ),
      //   ],
      // ),
    );
  }
}

class RecommendationCheckArea extends StatefulWidget {
  const RecommendationCheckArea({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<RecommendationCheckArea> createState() =>
      _RecommendationCheckAreaState();
}

class _RecommendationCheckAreaState extends State<RecommendationCheckArea> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        if(RecommendationModel.title == 'Hajj' ||RecommendationModel.title == "Umrah" ){

          RecommendationModel.recommendedRegion.add(widget.title);
          print('${RecommendationModel.recommendedRegion}');

          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ChatScreen();
          }),);

        }else{
          print(checkValue);
          if(checkValue == true){
            RecommendationModel.recommendedRegion.add(widget.title);
            print(RecommendationModel.recommendedRegion);
            checkValue = false;
            setState(() {
            });
          }else{
            if (RecommendationModel.recommendedRegion
                .contains(widget.title)) {
              RecommendationModel.recommendedRegion
                  .remove(widget.title);


              print(RecommendationModel.recommendedRegion);
              checkValue = true;
              setState(() {

              });
            }
          }
        }



      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.sp),
        alignment: const Alignment(0.01, -0.06),
        width: 307.sp,
        height: 50.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
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
        child: Row(
          children: [
            RecommendationModel.title == 'Hajj' ||RecommendationModel.title == "Umrah" ? SizedBox():     Transform.scale(
              scale: 1.3,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                value: checkValue,
                tristate: false,
                onChanged: (bool? newValue) {
                  setState(() {
                    if (newValue == true) {
                      RecommendationModel.recommendedRegion.add(widget.title);
                      print(RecommendationModel.recommendedRegion);
                    } else {
                      if (RecommendationModel.recommendedRegion
                          .contains(widget.title)) {
                        RecommendationModel.recommendedRegion
                            .remove(widget.title);

                        print(RecommendationModel.recommendedRegion);
                      }
                    }
                    checkValue = newValue!;
                  });
                },
                activeColor: AppColors.greenColor,
                side: const BorderSide(color: Color(0xff585858)),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
