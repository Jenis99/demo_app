import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../notifiers/notifier.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Notifier notifier;
  PackageInfo? packageInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationController.startListeningNotificationEvents();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(Duration(seconds: 3), () => startTimer());
    });

  }

  startTimer() async {
    PackageInfo packageInfo1 = await PackageInfo.fromPlatform();
    this.setState(() {
      packageInfo = packageInfo1;
    });
    AppVersionChecker().checkUpdate().then((value) async {
      if (value.canUpdate) {
        _displayDialog(context);
      } else {
        notifier = Provider.of<Notifier>(context, listen: false);
        notifier.appUpdateAndNavigation(context: context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: ColorRes.transparent,
          statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorRes.secondaryColor, ColorRes.primaryColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  ImageRes.logo_white,
                  width: 200,
                  height: 200,
                ),
              ),
        ]),
      ),
    );
  }

  void _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        // barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          // this was required, rest is same
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    height: 400,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              child: Image.asset(
                                ImageRes.logo,
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Update Available",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: ColorRes.primaryColor,
                                  height: 1),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextCustom(
                                text:"The current version of this application is no longer supported. we applogize for any inconvenience we may have caused you.",
                                textAlign: TextAlign.center,
                                fontSize: 18,
                                color: ColorRes.blackColor,
                                maxLines: 5,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // if(_msgListProvider.isCompulsory.toString()=="Y") {
                                      //   exit(0);
                                      // }else{
                                      //   navigate();
                                      // }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                        border: Border.all(
                                          color: ColorRes.darkpurpleColor,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        "Exit",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20)),
                                        border: Border.all(
                                          color: ColorRes.darkpurpleColor,
                                        ),
                                        color: ColorRes.darkpurpleColor,
                                      ),
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          });
        });
  }
}
