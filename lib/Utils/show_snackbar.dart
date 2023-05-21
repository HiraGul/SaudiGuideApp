import 'package:flutter/material.dart';
import 'package:saudi_guide/Utils/colors.dart';

showSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message.toString()),
    backgroundColor: AppColors.greenColor,
  ));
}
