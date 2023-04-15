import 'package:flutter/material.dart';
import 'color_resourse.dart';
import 'srting_resourse.dart';

class ButtonCustom extends StatelessWidget {
  final String titleText;
  final Color? buttonColor;
  final Color? textColor;
  final Icon? icon;
  final FontWeight? fontWeight;
  final double? fontSize,letterSpacing;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;

  const ButtonCustom({
    Key? key,
    required this.titleText,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.borderSide,
    this.borderRadius,
    this.icon,
    this.fontSize,
    this.padding, this.letterSpacing, this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? ColorRes.primaryColor,
          side: borderSide ?? const BorderSide(width: 0, color: Colors.transparent),
          shape: RoundedRectangleBorder(borderRadius: borderRadius??BorderRadius.circular(6)),
          padding: padding ?? const EdgeInsets.all(0)
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(icon!=null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: icon!,
              ),
            Text(
              titleText,
              style: TextStyle(
                color: textColor ?? ColorRes.whiteColor,
                fontWeight: fontWeight??FontWeight.w500,
                fontSize: fontSize ?? 16,
                fontFamily: StringRes.fontPoppins,
                letterSpacing: letterSpacing??0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
