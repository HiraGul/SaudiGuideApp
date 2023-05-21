import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/ORCCubit/ocrcubit_cubit.dart';
import 'package:saudi_guide/Models/oc_model_controller.dart';
import 'package:saudi_guide/Utils/colors.dart';

class OCR extends StatelessWidget {
  File file;

  OCR({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60.sp,
        color: Colors.black,
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
                      ))),
              child: Container(
                height: 0.8.sh,
                width: 100,
                margin: EdgeInsets.only(top: 0.2.sh),
                color: Colors.black.withOpacity(0.6),
                child: BlocBuilder<OcrcubitCubit, OcrcubitState>(
                  builder: (context, state) {
                    if (state is OcrcubitLoading) {
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
                        // Text(
                        //   'Tags ',
                        //   style: GoogleFonts.cairo(
                        //     fontSize: 22.0,
                        //     color: AppColors.greenColor,
                        //     fontWeight: FontWeight.w700,
                        //     height: 1.14,
                        //   ),
                        // ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: OCRController.ocrModel!.regions!.length,
                            itemBuilder: (context, xIndex) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: OCRController
                                      .ocrModel!.regions![xIndex].lines!.length,
                                  itemBuilder: (context, i) {
                                    return SizedBox(
                                      height: 20.sp,
                                      width: 1.sw,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: OCRController
                                              .ocrModel!
                                              .regions![xIndex]
                                              .lines![i]
                                              .words!
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.sp),
                                              child: Text(
                                                  OCRController
                                                      .ocrModel!
                                                      .regions![xIndex]
                                                      .lines![i]
                                                      .words![index]
                                                      .text!,
                                                  style: GoogleFonts.cairo(
                                                    fontSize: 14.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5,
                                                  )),
                                            );
                                          }),
                                    );
                                  });
                            }),

                        // SizedBox(
                        //   height: 20.sp,
                        // ),
                        // Text(
                        //   'Description ',
                        //   style: GoogleFonts.cairo(
                        //     fontSize: 22.0,
                        //     color: AppColors.greenColor,
                        //     fontWeight: FontWeight.w700,
                        //     height: 1.14,
                        //   ),
                        // ),
                        // Text(
                        //   LandMarkController
                        //       .landMark!.description!.captions![0].text!,
                        //   style: GoogleFonts.cairo(
                        //     fontSize: 14.0,
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.w500,
                        //     height: 1.5,
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
