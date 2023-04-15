import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textwidget_custom.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import 'dart:math' as math;

import '../utility/common_helper.dart';
import 'add_event_reminder_screen.dart';
import 'item/drawer_screen.dart';

class EventReminderScreen extends StatefulWidget {
  const EventReminderScreen({Key? key}) : super(key: key);

  @override
  State<EventReminderScreen> createState() => _EventReminderScreenState();
}

class _EventReminderScreenState extends State<EventReminderScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(selectedIndex: 4,),
      appBar: AppBarCustom(title: "Event reminder",scaffoldKey: scaffoldKey,actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, PageTransitionCustom(page: AddEventReminderScreen()));
                },
                child: ImageIcon(
                  AssetImage(ImageRes.ic_add_box),
                  color: ColorRes.whiteColor,
                ),
              ),
              SizedBox(width: 18,),
              InkWell(
                onTap: () {
                  //Navigator.push(context, PageTransitionCustom(page: NotificationScreen()));
                },
                child: ImageIcon(
                  AssetImage(ImageRes.ic_more),
                ),
              ),
            ],
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 14,),
              TextCustom(
                text: "Event type",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10,),
              TextCustom(
                text: "Birthday",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 22,),
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
              SizedBox(height: 22,),
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
              SizedBox(height: 5,),
              TextCustom(
                text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
                fontSize: 14,
                noMaxLines: false,
                height: 1.7,
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
