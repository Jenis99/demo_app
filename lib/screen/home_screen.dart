import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textwidget_custom.dart';
import 'package:wakiewakie/screen/add_reminder_screen.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import 'dart:math' as math;

import '../utility/common_helper.dart';
import 'add_wakeupcall_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Notifier notifier;
  StreamController<bool> wakeupController = StreamController();
  StreamController<bool> reminderController = StreamController();
  StreamController<bool> eventController = StreamController();
  late Stream wakeupswitchOutput = wakeupController.stream;
  late Sink wakeupswitchInput = wakeupController.sink;

  late Stream reminderswitchOutput = reminderController.stream;
  late Sink reminderswitchInput = reminderController.sink;
  late Stream eventswitchOutput = eventController.stream;
  late Sink eventswitchInput = eventController.sink;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wakeupswitchInput.add(true);
    reminderswitchInput.add(true);
    eventswitchInput.add(true);
  }
  @override
  Widget build(BuildContext context) {

    notifier = Provider.of<Notifier>(context,listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 13,),
              TextCustom(
                text: "Hello, Zoe",
                fontSize: 27,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 6,
              ),
              TextCustom(
                text: "Have a nice day!",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 31,
              ),
              Container(
                height: 145,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 121,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorRes.secondaryColor,
                                ColorRes.primaryColor
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                text: "Your Daily Wake Up Call",
                                fontSize: 16,
                                maxLines: 1,
                                color: ColorRes.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextCustom(
                                text: "5:00 am every day",
                                fontSize: 12,
                                color: ColorRes.whiteColor,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 82,
                                height: 30,
                                child: ButtonCustom(
                                  titleText: "ADD NEW",
                                  onPressed: () {
                                    Navigator.push(context, PageTransitionCustom(page: AddWakeUpCallScreen()));
                                  },
                                  fontSize: 10,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  borderSide: BorderSide(
                                      width: 1, color: ColorRes.whiteColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          ImageRes.alarm,
                          width: 89,
                          height: 126,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorRes.hintColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Image.asset(ImageRes.ic_wakeupcall,height: 23,width: 29,)),
                          SizedBox(
                            width: 15,
                          ),
                          TextCustom(
                            text: "Wakeup call",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.homeTextColor,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: wakeupswitchOutput,
                            builder: (context,snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return Switch(
                                  value: false,
                                  onChanged: (val) {
                                    //notifier.wakeUpSwitch = val;
                                  },
                                  trackColor: MaterialStateProperty.all(
                                      ColorRes.homeSwitchTrackColor),
                                  thumbColor:
                                  MaterialStateProperty.all(ColorRes.primaryColor),
                                );
                              }
                              bool value = snapshot.data;
                              return Switch(
                                value: value,
                                onChanged: (val) {
                                  wakeupswitchInput.add(val);
                                },
                                trackColor: MaterialStateProperty.all(
                                    ColorRes.homeSwitchTrackColor),
                                thumbColor:
                                MaterialStateProperty.all(ColorRes.primaryColor),
                              );
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: ColorRes.homeIconBackColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(
                              ImageRes.ic_settings,
                              color: ColorRes.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorRes.hintColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Image.asset(ImageRes.ic_homereminder,height: 23,width: 29,)),
                          SizedBox(
                            width: 15,
                          ),
                          TextCustom(
                            text: "Reminder",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.homeTextColor,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: reminderswitchOutput,
                            builder: (context,snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return Switch(
                                  value: false,
                                  onChanged: (val) {
                                    //notifier.wakeUpSwitch = val;
                                  },
                                  trackColor: MaterialStateProperty.all(
                                      ColorRes.homeSwitchTrackColor),
                                  thumbColor:
                                  MaterialStateProperty.all(ColorRes.primaryColor),
                                );
                              }
                              bool value = snapshot.data;
                              return Switch(
                                value: value,
                                onChanged: (val) {
                                  reminderswitchInput.add(val);
                                },
                                trackColor: MaterialStateProperty.all(
                                    ColorRes.homeSwitchTrackColor),
                                thumbColor:
                                MaterialStateProperty.all(ColorRes.primaryColor),
                              );
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: ColorRes.homeIconBackColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(
                              ImageRes.ic_settings,
                              color: ColorRes.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorRes.hintColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Image.asset(ImageRes.ic_homeevent,height: 23,width: 29,)),
                          SizedBox(
                            width: 15,
                          ),
                          TextCustom(
                            text: "Event reminder",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorRes.homeTextColor,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: eventswitchOutput,
                            builder: (context,snapshot) {
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return Switch(
                                  value: false,
                                  onChanged: (val) {
                                    //notifier.wakeUpSwitch = val;
                                  },
                                  trackColor: MaterialStateProperty.all(
                                      ColorRes.homeSwitchTrackColor),
                                  thumbColor:
                                  MaterialStateProperty.all(ColorRes.primaryColor),
                                );
                              }
                              bool value = snapshot.data;
                              return Switch(
                                value: value,
                                onChanged: (val) {
                                  eventswitchInput.add(val);
                                },
                                trackColor: MaterialStateProperty.all(
                                    ColorRes.homeSwitchTrackColor),
                                thumbColor:
                                MaterialStateProperty.all(ColorRes.primaryColor),
                              );
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: ColorRes.homeIconBackColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(
                              ImageRes.ic_settings,
                              color: ColorRes.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextCustom(
                    text: "Today Reminders",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorRes.homeTextColor,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransitionCustom(page: AddReminderScreen()));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: ColorRes.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: ImageIcon(
                          AssetImage(ImageRes.ic_plus),
                          color: ColorRes.whiteColor,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [1,2,3,4,5,6].map((e) {
                  int colorint  = (math.Random().nextDouble() * 0xFFFFFF).toInt();
                  Color color = Color(colorint).withOpacity(0.8);
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          text: "10:00 AM",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.homeTextColor,
                        ),
                        Expanded(
                          child: Container(
                            height: 70,
                            margin: EdgeInsets.only(left: 28),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: color.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 17),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          text: "Dentist appointment today",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: color,
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        TextCustom(
                                          text:
                                          "Lorem ipsum dolor sit amet, consetetur...",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: color,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 13,top: 10),
                                    child: ImageIcon(
                                      AssetImage(ImageRes.ic_more),
                                      size: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
