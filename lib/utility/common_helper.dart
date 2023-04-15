import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakiewakie/model/user_model.dart';
import '../notifiers/notifier.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import 'shared_preference_utility.dart';

dynamic PageTransitionCustom({required Widget page,PageTransitionType? pageTransitionType,Duration? duration}) {
  return PageTransition(
      child: page, type: pageTransitionType??PageTransitionType.scale, alignment: Alignment.center,
      duration: duration??const Duration(milliseconds: 100),
      );
}

println(value) {
  if (kDebugMode) {
    print(value);
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

Widget customLoader = Container(
  height: 140,
  width: 140,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
  child: Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 20,
        ),
        Text(
          "Please wait...",
          style: TextStyle(
              color: ColorRes.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: StringRes.fontPoppins),
        ),
      ],
    ),
  ),
);

PreferredSizeWidget AppBarCustom({title,List<Widget>? actions,leading, scaffoldKey,double paddingTitleTop = 0.0}) => AppBar(
  leading: leading??IconButton(
    icon: ImageIcon(AssetImage(ImageRes.ic_menu)),
    onPressed: () => scaffoldKey.currentState!.openDrawer(),
  ),
  leadingWidth: 50,
  title: Padding(
    padding: EdgeInsets.only(top: paddingTitleTop),
    child: TextCustom(text: title,letterSpacing: 1,fontSize: 18,fontWeight: FontWeight.w400,),
  ),
  elevation: 0,
  actions: actions,
);

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
              //Notifier().logout(context: context);
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

class DialogUtils {
  static void customDialog(BuildContext context,
      {required String title,
      required List<Widget> content,
      required GestureTapCallback? onTap}) {
    showDialog<void>(
        context: context,
        useSafeArea: true,
        barrierColor: ColorRes.blackColor.withOpacity(0.3),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              color: ColorRes.blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey.shade500,
                          height: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: content,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}

class CommonHelper {
//get user Data
  static Future<UserModel> getUserData() async {
    try {
      return UserModel.fromJson(
          json.decode(await SharedPreferencesUtility.getString("userData")));
    } catch (e) {
      return UserModel();
    }
  }

//get user Data
  static Future<String?> getUserId() async {
    try {
      UserModel userModel = UserModel.fromJson(
          json.decode(await SharedPreferencesUtility.getString("userData")));
      return (userModel.id ?? '').toString();
    } catch (e) {
      return '';
    }
  }

//calculate age
  static calculateAge(String birthDateString) {
    String datePattern = "yyyy-MM-dd";
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();
    int yearDiff = today.year - birthDate.year;
    return yearDiff;
  }

// get isLogin
  static Future<bool> isLogin() async {
    bool isLogin = await SharedPreferencesUtility.getBool("isLogin");
    return isLogin;
  }

// Call Url

  static void getWebSiteUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static void openCall(String number) async {
    if (!await launchUrl(Uri.parse('tel:$number'))) {
      throw 'Could not launch $number';
    }
  }

  // Call Url

  static void openMail(String mail) async {
    if (!await launchUrl(Uri.parse('mailto:$mail'))) {
      throw 'Could not launch $mail';
    }
  }

  // Call Url

  // Validation
  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (regex.hasMatch(value!.trim())) {
      return null;
    } else {
      return "Please enter Valid Email";
    }
  }

  // Validation
  static bool validatePassword(String value) {
    Pattern pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$";
    RegExp regex = RegExp(pattern.toString());
    if (regex.hasMatch(value.trim())) {
      return true;
    } else {
      return false;
    }
  }

  static String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.length != 10) {
      return 'Please enter Mobile Number must be of 10 digit';
    } else if (regExp.hasMatch(value.trim())) {
      return null;
    } else {
      return 'Please enter valid mobile number';
    }
  }

  // Date Format
  static String formattedDate(String value) {
    DateFormat format = DateFormat("dd-MM-yyyy");
    return DateFormat('dd-MM-yyyy 00:00:00.000').format(format.parse(value));
  }

  // Date Format

  // Toast
  static ToastFuture flutterToast(context, message,
      {color, fontColor, StyledToastPosition? position}) {
    return showToast(message,
        context: context,
        backgroundColor: color ?? ColorRes.darkpurpleColor,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.none,
        position: position ?? StyledToastPosition.bottom,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 5),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        textStyle: TextStyle(
            color: fontColor ?? Colors.white,
            fontSize: 16,
            letterSpacing: 0.5));
  }
// Toast

}
