import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'srting_resourse.dart';

class TextCustom extends StatelessWidget {
  final double fontSize;
  final int maxLines;
  bool noMaxLines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final String text;
  final double letterSpacing,height;
  final Function()? onPressed;
  TextCustom({Key? key,required this.text, this.fontSize = 16.0,this.noMaxLines = true,this.maxLines = 1,this.textAlign, this.fontFamily, this.color, this.decoration, this.fontWeight, this.letterSpacing = 0, this.onPressed, this.height = 1,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: noMaxLines?AutoSizeText(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily ?? StringRes.fontPoppins,
          fontWeight: fontWeight??FontWeight.w300,
          color: color,
          height: height,
          decoration: decoration,
          letterSpacing: letterSpacing,
        ),
        maxLines: maxLines,
        textAlign: textAlign,
        maxFontSize: fontSize,
        minFontSize: fontSize - 10,
      ):AutoSizeText(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily ?? StringRes.fontPoppins,
          fontWeight: fontWeight??FontWeight.w300,
          color: color,
          height: height,
          decoration: decoration,
          letterSpacing: letterSpacing,
        ),
        textAlign: textAlign,
        maxFontSize: fontSize,
        minFontSize: fontSize - 10,
      ),
    );
  }
}
