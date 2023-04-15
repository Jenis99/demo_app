import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/screen/change_password_screen.dart';
import 'package:wakiewakie/screen/edit_profile_screen.dart';
import 'package:wakiewakie/screen/item/drawer_screen.dart';
import 'package:wakiewakie/screen/profile_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';

import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notificationSwitch = false;
  bool wakeupSwitch = true;
  bool reminderSwitch = true;
  bool eventReminderSwitch = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(selectedIndex: 6,),
      appBar: AppBarCustom(title: "Settings",scaffoldKey: scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25,),
              InkWell(
                onTap: () {
                    Navigator.push(context, PageTransitionCustom(page: ProfileScreen(isPop:true)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageRes.ic_settings_account,
                        width: 24,
                        height: 24,
                        color: ColorRes.blackColor,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: TextCustom(
                          text: "Account",
                          fontSize: 14,
                          color: ColorRes.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageRes.ic_settings_notification,
                            width: 24,
                            height: 24,
                            color: ColorRes.blackColor,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: TextCustom(
                              text: "Notifications",
                              fontSize: 14,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Switch(
                        value: notificationSwitch,
                        onChanged: (val) {
                          setState(() {
                            notificationSwitch = val;
                          });
                        },
                        trackColor: MaterialStateProperty.all(
                            ColorRes.homeSwitchTrackColor),
                        thumbColor:
                        MaterialStateProperty.all(ColorRes.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
              SizedBox(height: 18,),
              InkWell(
                onTap: () {
                    Navigator.push(context, PageTransitionCustom(page: ChangePasswordScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageRes.ic_settings_lock,
                        width: 24,
                        height: 24,
                        color: ColorRes.blackColor,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: TextCustom(
                          text: "Change Password",
                          fontSize: 14,
                          color: ColorRes.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageRes.ic_setting_wakeup,
                            width: 24,
                            height: 24,
                            color: ColorRes.blackColor,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: TextCustom(
                              text: "Wakeup call",
                              fontSize: 14,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Switch(
                        value: wakeupSwitch,
                        onChanged: (val) {
                          setState(() {
                            wakeupSwitch = val;
                          });
                        },
                        trackColor: MaterialStateProperty.all(
                            ColorRes.homeSwitchTrackColor),
                        thumbColor:
                        MaterialStateProperty.all(ColorRes.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageRes.ic_settings_reminder,
                            width: 24,
                            height: 24,
                            color: ColorRes.blackColor,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: TextCustom(
                              text: "Reminder",
                              fontSize: 14,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Switch(
                        value: reminderSwitch,
                        onChanged: (val) {
                          setState(() {
                            reminderSwitch = val;
                          });
                        },
                        trackColor: MaterialStateProperty.all(
                            ColorRes.homeSwitchTrackColor),
                        thumbColor:
                        MaterialStateProperty.all(ColorRes.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
              SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageRes.ic_settings_event,
                            width: 24,
                            height: 24,
                            color: ColorRes.blackColor,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: TextCustom(
                              text: "Birthday reminder",
                              fontSize: 14,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Switch(
                        value: eventReminderSwitch,
                        onChanged: (val) {
                          setState(() {
                            eventReminderSwitch = val;
                          });
                        },
                        trackColor: MaterialStateProperty.all(
                            ColorRes.homeSwitchTrackColor),
                        thumbColor:
                        MaterialStateProperty.all(ColorRes.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18,),
              Divider(color: ColorRes.greyColor,),
            ],
          ),
        ),
      ),
    );
  }
}
