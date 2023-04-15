import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/item/drawer_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';
import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class NotificationScreen extends StatefulWidget {
  final bool isPop;

  const NotificationScreen({Key? key, this.isPop = true}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(selectedIndex: 5),
      appBar: AppBarCustom(
        title: "Notifications",
        paddingTitleTop: 5,
        scaffoldKey: scaffoldKey,
        leading: widget.isPop
            ? IconButton(
                icon: Image.asset(
                  ImageRes.ic_appbar_back,
                  width: 24,
                  height: 24,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          padding: EdgeInsets.only(top: 16),
          children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
              .map(
                (e) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: e == 1 || e == 2
                        ? ColorRes.notificationItembackColor
                        : ColorRes.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xff707070),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorRes.primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text:
                                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut",
                              fontSize: 10,
                              noMaxLines: false,
                              height: 1.4,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextCustom(
                              text: "09:49 AM",
                              fontSize: 10,
                              noMaxLines: false,
                              height: 1.7,
                              color: ColorRes.blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
