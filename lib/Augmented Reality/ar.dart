import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saudi_guide/Augmented%20Reality/landmark.dart';
import 'package:saudi_guide/Augmented%20Reality/ocr.dart';

import '../Cubits/ScanCubit/scan_land_mark_cubit.dart';

class AugmentedRealityScreen extends StatelessWidget {
  const AugmentedRealityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getFromCamera(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<ScanLandMarkCubit>(context)
            .getScanLandMarkData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LandMark(
                      file: imageFile,
                    )));
      }
    }

    getFromCameraOCR(BuildContext context) async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        BlocProvider.of<ScanLandMarkCubit>(context)
            .getScanLandMarkData(file: imageFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OCR(
                      file: imageFile,
                    )));
      }
    }

    return Scaffold(
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
                color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
        ),
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Augmented Reality',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF082B34),
          ),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              getFromCamera(context);
            },
            child: Container(
              color: Colors.white,
              height: 100.sp,
              width: 100.sp,
              child: Column(
                children: const [Icon(Icons.add), Text("Scan")],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              color: Colors.white,
              height: 100.sp,
              width: 100.sp,
              child: Column(
                children: const [Icon(Icons.add), Text("Scan LandMark")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
