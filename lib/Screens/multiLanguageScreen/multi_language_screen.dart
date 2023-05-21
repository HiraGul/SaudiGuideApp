import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saudi_guide/Cubits/ORCCubit/ocrcubit_cubit.dart';
import 'package:saudi_guide/Cubits/translate_list_cubit.dart';
import 'package:saudi_guide/Models/translate_model.dart';
import 'package:saudi_guide/Screens/widgets/button_container.dart';
import 'package:saudi_guide/Screens/widgets/my_form_field.dart';
import 'package:saudi_guide/Utils/show_snackbar.dart';

import '../../Repo/translate_repo.dart';
import '../../Utils/colors.dart';
import '../widgets/my_text.dart';

class MultiLanguageScreen extends StatefulWidget {
  const MultiLanguageScreen({super.key});

  @override
  State<MultiLanguageScreen> createState() => _MultiLanguageScreenState();
}

class _MultiLanguageScreenState extends State<MultiLanguageScreen> {
  String name = '';
  var controller = TextEditingController();
  var isLoading = ValueNotifier<bool>(false);
  getFromGalleryOCR(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      BlocProvider.of<OcrcubitCubit>(context).getOCRData(file: imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Multi Language',
          style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.appBarTitleColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: BlocBuilder<TranslateListCubit, List<TranslateModel>>(
            builder: (context, chatListState) {
              return ListView.builder(
                  // reverse: true,
                  padding:
                      EdgeInsets.only(top: 10.sp, right: 10.sp, left: 10.sp),
                  itemCount: chatListState.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.sp),
                      padding: EdgeInsets.only(
                          left: 15.sp, top: 20.sp, right: 15.sp, bottom: 15.sp),
                      // width: 374.sp,
                      // height: 105.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.sp),
                        color: const Color(0xFFF4FCFC),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF474747).withOpacity(0.1.sp),
                            offset: Offset(0, 3.sp),
                            blurRadius: 12.sp,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text:
                                      'How to say " ${chatListState[index].data!.detectedText} "',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              // Group: Group 16893
                              // Container(
                              //   alignment: const Alignment(0.0, -0.05),
                              //   width: 25.sp,
                              //   height: 25.sp,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     color: AppColors.greenColor,
                              //   ),
                              //   child: SvgPicture.string(
                              //     // volume
                              //     '<svg viewBox="0.0 15.99 10.96 10.23" ><path transform="translate(0.0, 0.0)" d="M 6.36783504486084 16.02653503417969 C 6.240726947784424 15.96590328216553 6.090972423553467 15.98197460174561 5.981396198272705 16.07036590576172 L 2.428207159042358 18.91276931762695 L 0.7305075526237488 18.91276931762695 C 0.3279979228973389 18.91276931762695 0 19.24077033996582 0 19.64328002929688 L 0 22.5653076171875 C 0 22.96854972839355 0.3279979228973389 23.29581642150879 0.7305075526237488 23.29581642150879 L 2.428207159042358 23.29581642150879 L 5.980666637420654 26.13822174072266 C 6.047141551971436 26.19081687927246 6.128228664398193 26.21784591674805 6.209313869476318 26.21784591674805 C 6.26337194442749 26.21784591674805 6.317429542541504 26.20542907714844 6.36783504486084 26.18132209777832 C 6.494213104248047 26.12068939208984 6.574568271636963 25.99284934997559 6.574568271636963 25.85259246826172 L 6.574568271636963 16.35599327087402 C 6.574568271636963 16.21573638916016 6.494213104248047 16.08789825439453 6.36783504486084 16.02653503417969 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-333.95, -103.84)" d="M 342.3735961914062 122.3577270507812 C 342.2296752929688 122.2160186767578 341.9988098144531 122.2182006835938 341.8571166992188 122.3606567382812 C 341.7153625488281 122.5045776367188 341.7168273925781 122.7354125976562 341.8599853515625 122.8778533935547 C 342.4123229980469 123.4228210449219 342.7161865234375 124.155517578125 342.7161865234375 124.9408111572266 C 342.7161865234375 125.7261047363281 342.4123229980469 126.4588012695312 341.8599853515625 127.0037689208984 C 341.7168273925781 127.1447601318359 341.7153625488281 127.3763122558594 341.8571166992188 127.5202331542969 C 341.9287109375 127.5925598144531 342.0229187011719 127.6283416748047 342.1164245605469 127.6283416748047 C 342.2091979980469 127.6283416748047 342.302001953125 127.5932769775391 342.3735961914062 127.5224151611328 C 343.0661010742188 126.8408660888672 343.4466857910156 125.92333984375 343.4466857910156 124.9408111572266 C 343.4466857910156 123.9582672119141 343.0661010742188 123.0407562255859 342.3735961914062 122.3577270507812 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-378.04, -59.74)" d="M 387.4905395507812 77.23082733154297 C 387.3466186523438 77.08837890625 387.1157836914062 77.08982849121094 386.9733581542969 77.23302459716797 C 386.8316040039062 77.37619018554688 386.8330688476562 77.60775756835938 386.9755249023438 77.74948120117188 C 387.8060913085938 78.57276916503906 388.2633972167969 79.67144775390625 388.2633972167969 80.84318542480469 C 388.2633972167969 82.01491546630859 387.8060913085938 83.11286926269531 386.9755249023438 83.93614959716797 C 386.8330688476562 84.07860565185547 386.8316040039062 84.31017303466797 386.9733581542969 84.45335388183594 C 387.045654296875 84.52494049072266 387.13916015625 84.56074523925781 387.2326354980469 84.56074523925781 C 387.3254699707031 84.56074523925781 387.4189758300781 84.52566528320312 387.4905395507812 84.45481109619141 C 388.4606323242188 83.49419403076172 388.9939270019531 82.21142578125 388.9939270019531 80.84318542480469 C 388.9939270019531 79.47493743896484 388.4606323242188 78.19216918945312 387.4905395507812 77.23082733154297 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              //     width: 10.96.sp,
                              //     height: 10.23.sp,
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          MyText(
                            text:
                                "${chatListState[index].data!.translations![0].translatedText}",
                            size: 12.sp,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                    );
                  });
            },
          )),
          Container(
            width: 414.sp,
            height: 190.sp,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: controller,
                    keyboardType: TextInputType.multiline),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 74.0,
                        height: 48.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              width: 74.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: const Color(0xFFCAF1EE),
                              ),
                            ),
                            Positioned(
                              bottom: 9.0,
                              child: InkWell(
                                onTap: () {
                                  getFromGalleryOCR(context);
                                },
                                child: SizedBox(
                                  width: 25.37.sp,
                                  height: 25.37.sp,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: SvgPicture.string(
                                          // Path 13967
                                          '<svg viewBox="18.31 18.31 9.06 9.06" ><path transform="translate(-1.69, -1.69)" d="M 28.15546417236328 23.6246509552002 L 25.43697547912598 23.6246509552002 L 25.43697547912598 20.90616226196289 C 25.43697547912598 20.40570259094238 25.03127288818359 20 24.53081321716309 20 C 24.03035354614258 20 23.6246509552002 20.40570259094238 23.6246509552002 20.90616226196289 L 23.6246509552002 23.6246509552002 L 20.90616226196289 23.6246509552002 C 20.40570259094238 23.6246509552002 20 24.03035354614258 20 24.53081321716309 C 20 25.03127288818359 20.40570259094238 25.43697547912598 20.90616226196289 25.43697547912598 L 23.6246509552002 25.43697547912598 L 23.6246509552002 28.15546417236328 C 23.6246509552002 28.65592384338379 24.03035354614258 29.06162643432617 24.53081321716309 29.06162643432617 C 25.03127288818359 29.06162643432617 25.43697547912598 28.65592384338379 25.43697547912598 28.15546417236328 L 25.43697547912598 25.43697547912598 L 28.15546417236328 25.43697547912598 C 28.65592384338379 25.43697547912598 29.06162643432617 25.03127288818359 29.06162643432617 24.53081321716309 C 29.06162643432617 24.03035354614258 28.65592384338379 23.6246509552002 28.15546417236328 23.6246509552002 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                          width: 9.06,
                                          height: 9.06,
                                        ),
                                      ),
                                      SvgPicture.string(
                                        // Path 13968
                                        '<svg viewBox="2.0 2.0 21.75 21.75" ><path  d="M 15.59244251251221 21.93558120727539 L 4.718488693237305 21.93558120727539 C 4.218028545379639 21.93558120727539 3.812325477600098 21.52987670898438 3.812325477600098 21.02941703796387 L 3.812325477600098 4.718488693237305 C 3.812325477600098 4.218028545379639 4.218028545379639 3.812325477600098 4.718488693237305 3.812325477600098 L 21.02941703796387 3.812325477600098 C 21.52987670898438 3.812325477600098 21.93558120727539 4.218028545379639 21.93558120727539 4.718488693237305 L 21.93558120727539 15.59244251251221 C 21.93558120727539 16.0929012298584 22.34128379821777 16.49860382080078 22.84174346923828 16.49860382080078 C 23.34220314025879 16.49860382080078 23.74790573120117 16.0929012298584 23.74790573120117 15.59244251251221 L 23.74790573120117 4.718488693237305 C 23.74790573120117 3.217108488082886 22.53079795837402 2 21.02941703796387 2 L 4.718488693237305 2 C 3.217108488082886 2 1.999999523162842 3.217109203338623 2 4.718489170074463 L 2 21.02941703796387 C 2 22.53079795837402 3.217108726501465 23.74790573120117 4.718488693237305 23.74790573120117 L 15.59244251251221 23.74790573120117 C 16.0929012298584 23.74790573120117 16.49860382080078 23.34220314025879 16.49860382080078 22.84174346923828 C 16.49860382080078 22.34128379821777 16.0929012298584 21.93558120727539 15.59244251251221 21.93558120727539 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                        width: 21.75,
                                        height: 21.75,
                                      ),
                                      Positioned(
                                        left: 5.0,
                                        top: 3.0,
                                        child: Container(
                                          width: 4.53,
                                          height: 4.53,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.greenColor,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 3.0,
                                        bottom: 7.0,
                                        child: SvgPicture.string(
                                          // Path 13969
                                          '<svg viewBox="5.62 10.15 14.5 9.97" ><path transform="translate(-0.38, -0.84)" d="M 7.168950080871582 13.98073101043701 L 6 15.15874290466309 L 6 20.96724700927734 L 20.49860382080078 20.96724700927734 L 20.49860382080078 15.15874290466309 L 16.61116409301758 11.26224327087402 C 16.44101715087891 11.09069442749023 16.20940780639648 10.99420166015625 15.96779155731201 10.99420166015625 C 15.72617435455322 10.99420166015625 15.49456214904785 11.09069442749023 15.3244161605835 11.26224327087402 L 10.53081321716309 16.06490707397461 L 8.455700874328613 13.98073101043701 C 8.285552978515625 13.80918312072754 8.05394172668457 13.71268939971924 7.812324523925781 13.71268939971924 C 7.57070779800415 13.71268939971924 7.339096069335938 13.80918312072754 7.168949127197266 13.98073101043701 Z" fill="#299e97" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                          width: 14.5,
                                          height: 9.97,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (controller.text.isNotEmpty) {
                            // context.read<MultiLanguageCubit>().textTranslation(
                            //     context, controller.text.trim());
                            isLoading.value = !isLoading.value;
                            var result = await TranslateTextRepo()
                                .translateText(context, controller.text.trim());
                            if (result == 501) {
                              showSnackBar(context, "no internet connection");
                              // isLoading.value = !isLoading.value;
                            }

                            isLoading.value = !isLoading.value;
                            controller.clear();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: ButtonContainer(
                            widget: ValueListenableBuilder(
                                valueListenable: isLoading,
                                builder: (context, value, child) {
                                  if (value) {
                                    return const CircularProgressIndicator(
                                      color: Colors.white,
                                    );
                                  } else {
                                    return MyText(
                                      text: "Translate",
                                      size: 18.sp,
                                      weight: FontWeight.w600,
                                      color: Colors.white,
                                    );
                                  }
                                })),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
