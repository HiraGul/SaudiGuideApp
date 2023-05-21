import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Cubits/ScanCubit/scan_land_mark_cubit.dart';

import '../Models/land_mark_controller.dart';

class LandMark extends StatelessWidget {
  File file;

  LandMark({Key? key, required this.file}) : super(key: key);

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
              child: BlocBuilder<ScanLandMarkCubit, ScanLandMarkState>(
                builder: (context, state) {
                  if (state is ScanLandMarkLoading) {
                    return CircularProgressIndicator();
                  }
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    children: [
                      SizedBox(
                        height: 0.4.sh,
                      ),
                      Text(
                        LandMarkController
                            .landMark!.description!.captions![0].text!,
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        height: 0.6.sh,
                        width: 100,
                        color: Colors.black.withOpacity(0.7),
                        child: ListView.builder(
                            itemCount: LandMarkController
                                .landMark!.description!.tags!.length,
                            itemBuilder: (context, i) {
                              return Text(
                                LandMarkController
                                    .landMark!.description!.tags![i]
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              );
                            }),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
