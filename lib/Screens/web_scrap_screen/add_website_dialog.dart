import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/web_scrap_cubit/web_scrap_cubit.dart';
import 'package:saudi_guide/Utils/colors.dart';

import '../widgets/my_form_field.dart';

class AddWebsiteDialog extends StatefulWidget {
  const AddWebsiteDialog({Key? key}) : super(key: key);

  @override
  State<AddWebsiteDialog> createState() => _AddWebsiteDialogState();
}

class _AddWebsiteDialogState extends State<AddWebsiteDialog> {
  TextEditingController websiteNameController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          children: [
            SizedBox(
              height: 20.sp,
            ),
            Text('Enter your website',style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
            ),textAlign: TextAlign.center,),
            Text(
              'Website name',
              style: GoogleFonts.cairo(),
            ),
            SizedBox(
              height: 4.sp,
            ),
            MyFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required';
                } else {
                  return null;
                }
              },
              controller: websiteNameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 4.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'Website url',
              style: GoogleFonts.cairo(),
            ),
            SizedBox(
              height: 4.sp,
            ),
            MyFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field is required';
                } else {
                  return null;
                }
              },
              controller: linkController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10.sp,
            ),
            BlocListener<WebScrapCubit, WebScrapState>(
              listener: (context, state) {
                if (state is WebScrapError) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: state.error, backgroundColor: Colors.red);
                }
                if (state is WebScrapLoaded) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: 'Your data is ready', backgroundColor: Colors.green);
                }
                // TODO: implement listener
              },
              child: isLoading
                  ? SizedBox(
                  height: 45.sp,
                  child: Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: AppColors.greenColor,
                      rightDotColor: Colors.black,
                      size: 40.sp,
                    ),
                  ))
                  : InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    context.read<WebScrapCubit>().getScrapData(
                      url: linkController.text.trim(),
                      websiteName: websiteNameController.text.trim(),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.greenColor),
                  height: 40.sp,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
