import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Cubits/stable_disfussion_repo/text_to_image_cubit.dart';
import 'package:saudi_guide/Screens/imagine_saudi_screen/show_image_screen.dart';
import 'package:saudi_guide/Utils/colors.dart';

import '../../Models/image_saudi_model.dart';
import '../widgets/button_container.dart';
import '../widgets/my_form_field.dart';
import '../widgets/my_text.dart';

class ImagineSaudiScreen extends StatefulWidget {
  const ImagineSaudiScreen({Key? key}) : super(key: key);

  @override
  State<ImagineSaudiScreen> createState() => _ImagineSaudiScreenState();
}

class _ImagineSaudiScreenState extends State<ImagineSaudiScreen> {
  TextEditingController textController = TextEditingController();

  List<ImageSaudiModel> list = [
    ImageSaudiModel(
        displayQuestion: 'View the amazing view of The Holy Kaaba:',
        prompt:
            "a stunning 3D rendering of the Holy Kaaba from a dramatic low angle, with intricate details and"
            "textures, inspired by Islamic geometric art and architecture. "
            "Rendered in V-Ray or Arnold for maximum photorealism,"
            " with dynamic lighting to enhance the atmosphere and mood."
            " References to influential artists like Zaha Hadid or Hassan Fathy "
            "can be included for inspiration. Hi-res aspect ratio of 16:9 –beta –upbeta",
        seed: 121),
    ImageSaudiModel(
        displayQuestion:
            'Are we going to have flying cars in KSA? come, let\'s imagine',
        prompt:
            "a stunning and futuristic aerial view of a bustling city in Saudi Arabia, filled with sleek flying cars"
            "zooming through the air. The image should capture the "
            "excitement and energy of this cutting-edge technology "
            "while also showcasing the beauty of the surrounding landscape. "
            "Consider using inspiration from Blade Runner 2049 or other sci-fi"
            " films to create a visually striking and immersive image that "
            "inspires awe and wonder. –beta –ar 21:9",
        seed: 20000),
    ImageSaudiModel(
        displayQuestion: 'Future view of Saudi in 2080',
        prompt:
            "a futuristic digital painting artwork of a bustling and vibrant Saudi Arabian cityscape in 2080, with"
            "sleek skyscrapers, advanced technology, green spaces,"
            " and diverse communities living harmoniously. Inspired "
            "by the works of Syd Mead, Masdar City, and Blade Runner 2049,"
            " this image is highly detailed and photorealistic, rendered in"
            " high resolution using Unreal Engine or Unity. –beta –upbeta –a",
        seed: 20000),
    ImageSaudiModel(
        displayQuestion: 'AL Ula desert tourist feel in sunset:',
        prompt: "a stunning landscape photo of a desert oasis in Al Ula, "
            "Saudi Arabia at sunset. The colors are warm"
            "and vibrant with orange hues reflecting off the sandstone "
            "cliffs, while palm trees and water pools add to the lushness of "
            "the scene. This image is inspired by National Geographic's photography"
            " style and was captured using a Canon EOS R5 camera with a wide-angle lens "
            "for maximum detail and clarity –beta –ar 3:2 –upbeta",
        seed: 121),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.sp,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5.sp),
            width: 31.sp,
            height: 31.sp,
            margin: EdgeInsets.only(left: 15.sp),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 15.sp,
            ),
          ),
        ),
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Imagine Saudi',
          style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.appBarTitleColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<TextToImageCubit>()
                          .getImage(model: list[index]);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShowImageScreen();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15.sp),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 20.sp),
                      decoration: BoxDecoration(
                          color: Color(0xffF4FCFC),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withAlpha(100),
                                blurRadius: 10)
                          ],
                          // border: Border.all(color: const Color(0xff707070)),
                          borderRadius: BorderRadius.circular(11.sp)),
                      child: Text(
                        list[index].displayQuestion,
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            width: 414.sp,
            padding: EdgeInsets.all(15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.sp),
              ),
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: const Color(0xFFEFEFEF),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5E5E5E).withOpacity(0.1),
                  offset: Offset(0, 3.0.sp),
                  blurRadius: 12.0.sp,
                ),
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MyText(
                  text: 'Enter Text',
                  size: 15.sp,
                  color: const Color(0xff858585),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                MyFormField(
                  hintText: 'Type here to imagine anything you want to ',
                  controller: textController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                InkWell(
                  onTap: () {
                    if (textController.text.isNotEmpty) {


                      FocusScope.of(context).unfocus();
                      var data = ImageSaudiModel(
                        displayQuestion: '',
                        prompt: textController.text.trim(),
                        seed: 888,
                      );
                      context.read<TextToImageCubit>().getUserInputImage(model: data);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){

                        return const ShowImageScreen();
                      }));
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 45.sp,
                      child: ButtonContainer(
                          widget: MyText(
                        text: "Generate Image",
                        size: 18.sp,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
