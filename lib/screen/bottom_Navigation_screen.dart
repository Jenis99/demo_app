import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/textwidget_custom.dart';
import 'package:wakiewakie/screen/notification_screen.dart';
import 'package:wakiewakie/screen/wakeupcall_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import 'add_wakeupcall_screen.dart';
import 'home_screen.dart';
import 'item/drawer_screen.dart';
import 'profile_screen.dart';
import 'reminder_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int index;

  const BottomNavigationScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedTab = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = [
    HomeScreen(),
    WakeUpCallScreen(),
    ReminderScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTab = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(
        selectedIndex: selectedTab,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: ImageIcon(AssetImage(ImageRes.ic_menu)),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
        leadingWidth: 50,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextCustom(
            text: selectedTab == 0
                ? "Home"
                : selectedTab == 1
                    ? "Wakeup call"
                    : selectedTab == 2
                        ? "Reminder"
                        : "Profile",
            letterSpacing: 1,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
        actions: [
          if (selectedTab == 0)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, PageTransitionCustom(page: NotificationScreen()));
                },
                child: ImageIcon(
                  AssetImage(ImageRes.ic_notification),
                ),
              ),
            ),
          if (selectedTab == 1)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransitionCustom(page: AddWakeUpCallScreen()));
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
        ],
      ),
      body: pages[selectedTab],
      bottomNavigationBar: Container(
        height: 65,
        color: ColorRes.primaryColor,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: BottomNavigationBar(
                  backgroundColor: ColorRes.primaryColor,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: ColorRes.whiteColor,
                  unselectedItemColor: ColorRes.whiteColor,
                  selectedFontSize: 10,
                  selectedLabelStyle: const TextStyle(
                      fontFamily: StringRes.fontPoppins,
                      fontWeight: FontWeight.w400),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: StringRes.fontPoppins,
                      fontWeight: FontWeight.w400),
                  unselectedFontSize: 10,
                  currentIndex: selectedTab,
                  onTap: (int index) {
                    setState(() {
                      selectedTab = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage(ImageRes.ic_home),
                        size: 24,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(ImageRes.ic_wakeup), size: 24),
                      label: "Wakeup call",
                    ),
                    BottomNavigationBarItem(
                      icon:
                          ImageIcon(AssetImage(ImageRes.ic_reminder), size: 24),
                      label: "Reminder",
                    ),
                    BottomNavigationBarItem(
                      icon:
                          ImageIcon(AssetImage(ImageRes.ic_profile), size: 24),
                      label: "Profile",
                    ),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          color: selectedTab == 0
                              ? ColorRes.whiteColor
                              : ColorRes.transparent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          color: selectedTab == 1
                              ? ColorRes.whiteColor
                              : ColorRes.transparent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          color: selectedTab == 2
                              ? ColorRes.whiteColor
                              : ColorRes.transparent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          color: selectedTab == 3
                              ? ColorRes.whiteColor
                              : ColorRes.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
