import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wakiewakie/screen/bottom_Navigation_screen.dart';
import 'package:wakiewakie/screen/home_screen.dart';
import 'package:wakiewakie/screen/notification_screen.dart';
import 'package:wakiewakie/screen/settings_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';

import '../../notifiers/notifier.dart';
import '../../resources/color_resourse.dart';
import '../../resources/image_resourse.dart';
import '../../resources/textwidget_custom.dart';
import '../aboutus_screen.dart';
import '../event_reminder_screen.dart';

class DrawerScreen extends StatefulWidget {
  final int selectedIndex;
  const DrawerScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  late int selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorRes.whiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorRes.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width*0.75,
          child: Drawer(
            backgroundColor: ColorRes.whiteColor,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: BottomNavigationScreen(),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 0
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_home,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 0
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Home",
                                  fontSize: 14,
                                  color: selectedIndex == 0
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: BottomNavigationScreen(index: 2,),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 2
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_reminder,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 2
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Reminders",
                                  fontSize: 14,
                                  color: selectedIndex == 2
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: BottomNavigationScreen(index: 1,),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 1
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_wakeup,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 1
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Wakeup call",
                                  fontSize: 14,
                                  color: selectedIndex == 1
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 4;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: EventReminderScreen(),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 4
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_event,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 4
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Event reminder",
                                  fontSize: 14,
                                  color: selectedIndex == 4
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: BottomNavigationScreen(index: 3,),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 3
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_profile,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 3
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "My Profile",
                                  fontSize: 14,
                                  color: selectedIndex == 3
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 5;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: NotificationScreen(isPop: false,),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 5
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_notification,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 5
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Notifications",
                                  fontSize: 14,
                                  color: selectedIndex == 5
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 6;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: SettingScreen(),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 6
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_settings,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 6
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Settings",
                                  fontSize: 14,
                                  color: selectedIndex == 6
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 7;
                        });
                        Navigator.pushReplacement(
                          context,
                          PageTransitionCustom(
                            page: AboutUsScreen(),
                            pageTransitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 7
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_aboutus,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 7
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "About Us",
                                  fontSize: 14,
                                  color: selectedIndex == 7
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   selectedIndex = 8;
                        // });
                        // Navigator.pushReplacement(
                        //   context,
                        //   PageTransitionCustom(
                        //     page: BottomNavigationScreen(),
                        //     pageTransitionType: PageTransitionType.rightToLeft,
                        //     duration: Duration(milliseconds: 500),
                        //   ),
                        // );
                      },
                      child: Container(
                        height: 46,
                        color: selectedIndex == 8
                            ? ColorRes.primaryColor
                            : ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_contactus,
                                width: 20,
                                height: 20,
                                color: selectedIndex == 8
                                    ? ColorRes.whiteColor
                                    : ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Contact Us",
                                  fontSize: 14,
                                  color: selectedIndex == 8
                                      ? ColorRes.whiteColor
                                      : ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    InkWell(
                      onTap: () {
                        islogout(context);
                      },
                      child: Container(
                        height: 46,
                        color: ColorRes.whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageRes.ic_drawer_logout,
                                width: 20,
                                height: 20,
                                color: ColorRes.blackColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextCustom(
                                  text: "Logout",
                                  fontSize: 14,
                                  color: ColorRes.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  islogout(context) {
    DialogUtils.customDialog(context, title: "Logout", onTap: () {
      Navigator.pop(context);
    }, content: [
      const SizedBox(
        height: 10,
      ),
      Center(
        child: Text(
          "Are you sure you want to logout?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: ColorRes.blackColor,
              fontSize: 15),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton(
              onPressed: () async {
                Navigator.pop(context);
                Notifier().logout(context: context);
              },
              style: ElevatedButton.styleFrom(
                  primary: ColorRes.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(13)),
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      color: ColorRes.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  )),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                //primary: ColorRes.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ColorRes.primaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.all(13)),
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    "No",
                    style: TextStyle(
                      color: ColorRes.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  )),
            ),
          ),
        ],
      )
    ]);
  }
}
