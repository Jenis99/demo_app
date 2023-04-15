import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textwidget_custom.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import 'dart:math' as math;

class WakeUpCallScreen extends StatefulWidget {
  const WakeUpCallScreen({Key? key}) : super(key: key);

  @override
  State<WakeUpCallScreen> createState() => _WakeUpCallScreenState();
}

class _WakeUpCallScreenState extends State<WakeUpCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 26,),
              TextCustom(
                text: "Wakeup call time",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10,),
              TextCustom(
                text: "05.00 AM",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 31,),
              TextCustom(
                text: "Photo/smiley",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 12,),
              Image.asset(ImageRes.img_demo),
              SizedBox(height: 20,),
              TextCustom(
                text: "Alarm",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10,),
              TextCustom(
                text: "Repeat Daily",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 31,),
              TextCustom(
                text: "Voice",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 15,),
              TextCustom(
                text: "Ringtone 1",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 30,),
              TextCustom(
                text: "Message",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 15,),
              TextCustom(
                text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
                fontSize: 14,
                noMaxLines: false,
                height: 1.7,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
