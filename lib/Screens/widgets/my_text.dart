import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  MyText(
      {super.key,
      required this.text,
      this.underline = false,
      this.color,
      required this.size,
      this.textAlign,
      this.weight});

  final String text;
  final double size;
  FontWeight? weight;
  Color? color;
  TextAlign? textAlign;
  bool? underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.openSans(
        color: color,
        decoration: underline! ? TextDecoration.underline : null,
        fontSize: size,
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}
