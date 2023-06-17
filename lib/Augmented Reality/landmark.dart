import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/ScanCubit/scan_land_mark_cubit.dart';

import '../Models/chat_model.dart';
import '../Models/land_mark_controller.dart';
import '../Screens/chat_screen/chat_screen.dart';
import '../Utils/colors.dart';

class LandMark extends StatelessWidget {
  File file;

  LandMark({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        LandMarkController.landMark = null;
        return true;
      },
      child: Scaffold(

        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
          ]),
          height: 70.h,
          child: InkWell(
            onTap: () {

              RecommendationModel.title= 'Landmark';
              RecommendationModel.recommendedRegion = [];
              print(
                  '${LandMarkController.landMark?.description?.tags?.join(' , ')}');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ChatScreen();
              }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.sp),
                color:              AppColors.greenColor,
              ),
              child: Center(
                child: Text(
                  'Lets Chat',
                  style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: 1.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(file.path),
                    ),
                  ),
                ),
                child: Container(
                  height: 0.6.sh,
                  width: 100,
                  margin: EdgeInsets.only(top: 0.2.sh),
                  color: Colors.black.withOpacity(0.6),
                  child: BlocBuilder<ScanLandMarkCubit, ScanLandMarkState>(
                    builder: (context, state) {
                      if (state is ScanLandMarkException) {
                        return Text('Exception occurred',
                            style: GoogleFonts.cairo(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ));
                      }
                      if (state is ScanLandMarkLoading) {
                        return Align(
                          alignment: Alignment.center,
                          child: LoadingAnimationWidget.twistingDots(
                            leftDotColor: AppColors.greenColor,
                            rightDotColor: Colors.black,
                            size: 40.sp,
                          ),
                        );
                      }
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 30.sp),
                        children: [
                          SizedBox(height: 20.sp),
                          Text(
                            'Tags ',
                            style: GoogleFonts.cairo(
                              fontSize: 22.0,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.w700,
                              height: 1.14,
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: LandMarkController
                                  .landMark!.description!.tags!.length,
                              itemBuilder: (context, i) {
                                return Text(
                                    ' ${i + 1} ${LandMarkController.landMark!.description!.tags![i].toString()}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                    ));
                              }),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Text(
                            'Description ',
                            style: GoogleFonts.cairo(
                              fontSize: 22.0,
                              color: AppColors.greenColor,
                              fontWeight: FontWeight.w700,
                              height: 1.14,
                            ),
                          ),
                          Text(
                            LandMarkController
                                .landMark!.description!.captions![0].text!,
                            style: GoogleFonts.cairo(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
