import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/stable_disfussion_repo/text_to_image_cubit.dart';
import 'package:saudi_guide/Utils/colors.dart';

class ShowImageScreen extends StatelessWidget {
  const ShowImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.sp,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5.sp),
            width: 31.sp,
            height: 31.sp,
            margin: EdgeInsets.only(left: 15.sp),
            decoration:  BoxDecoration(
                color:              AppColors.greenColor,
                 shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 15.sp,
            ),
          ),
        ),
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Image',
          style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,),
        ),
      ),

      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<TextToImageCubit, TextToImageState>(
          listener: (context, state) {
            if(state is TextToImageError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));

              Navigator.of(context).pop();

            }
            // TODO: implement listener
          },
          child: BlocBuilder<TextToImageCubit, TextToImageState>(
            builder: (context, state) {
              if (state is TextToImageLoaded) {
                return Center(
                  child: SizedBox(
                      height: 0.8.sh,
                      child: Image.memory(state.image)),
                );
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: AppColors.greenColor,
                    rightDotColor: Colors.white,
                    size: 40.sp,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
