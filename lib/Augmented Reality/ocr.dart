import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saudi_guide/Models/oc_model_controller.dart';

class OCR extends StatelessWidget {
  File file;

  OCR({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(OCRController.ocrModel!.regions![0].lines![0].words![0].text
          .toString()),
    );
  }
}
