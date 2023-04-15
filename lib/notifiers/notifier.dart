import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/screen/bottom_Navigation_screen.dart';
import 'package:wakiewakie/screen/home_screen.dart';
import 'package:wakiewakie/screen/new_password_screen.dart';
import 'package:wakiewakie/screen/otp_screen.dart';
import '../config/config.dart';
import '../resources/color_resourse.dart';
import '../screen/profile_screen.dart';
import '../screen/signin_screen.dart';
import '../utility/common_helper.dart';
import '../utility/network/api_handler.dart';
import '../utility/network/error_handler.dart';
import '../utility/shared_preference_utility.dart';

class Notifier with ChangeNotifier {
  bool _wakeUpSwitch = true;
  bool _reminderSwitch = true;
  bool _eventReminderSwitch = true;
  bool? _isLogin;

  bool? get isLogin => _isLogin;

  set isLogin(bool? value) {
    _isLogin = value;
    notifyListeners();
  }

  bool get wakeUpSwitch => _wakeUpSwitch;

  set wakeUpSwitch(bool value) {
    _wakeUpSwitch = value;
    notifyListeners();
  }

  bool get reminderSwitch => _reminderSwitch;

  set reminderSwitch(bool value) {
    _reminderSwitch = value;
    notifyListeners();
  }

  bool get eventReminderSwitch => _eventReminderSwitch;

  set eventReminderSwitch(bool value) {
    _eventReminderSwitch = value;
    notifyListeners();
  }

  checkIsLogin(context) async {
    isLogin = await SharedPreferencesUtility.getBool("isLogin");
  }

  // ISLOGIN CHECK
  appUpdateAndNavigation({required context}) async {
    bool isLogin = await SharedPreferencesUtility.getBool("isLogin");
    if (isLogin) {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransitionCustom(page: const BottomNavigationScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransitionCustom(page: const SignInScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  logout({required context}) async {
    await SharedPreferencesUtility.clearSharedPrefrences();
    Navigator.pushAndRemoveUntil(
      context,
      PageTransitionCustom(page: const SignInScreen()),
      (Route<dynamic> route) => false,
    );
  }

// user name register
  register({
    required context,
    required username,
    required lastname,
    required contact,
    required email,
    required password,
    required dob,
    required notificationtoken,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.REGISTER, context, body: {
        "username": username,
        "lastname": lastname,
        "contact": contact,
        "email": email,
        "password": password,
        "dob": dob,
        "notificationtoken": notificationtoken
      }).then((dynamic value) async {
        print(value);
        Loader.hide();
        if (value["status"] == "true") {
          Navigator.push(
            context,
            PageTransitionCustom(
              page: OtpScreen(
                screenName: "register",
                otp: value["otp"].toString(),
                mobileNo: contact,
                userId: value["userid"].toString(),
              ),
            ),
          );
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      print(ex.code);
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

// user name register

  // user Login
  login({
    required context,
    required email,
    required password,
    required notificationtoken,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.LOGIN, context, body: {
        "email": email,
        "password": password,
        "notificationtoken": notificationtoken
      }).then((dynamic value) async {
        print(value);
        Loader.hide();
        if (value["status"] == "true") {
          await SharedPreferencesUtility.setString(
              "userData", json.encode(value["data"]));
          await SharedPreferencesUtility.setBool("isLogin", true);
          Navigator.pushAndRemoveUntil(
            context,
            PageTransitionCustom(
              page: const BottomNavigationScreen(),
            ),
            (route) => false,
          );
        } else if (value["status"] == "notvarified") {
          Navigator.push(
            context,
            PageTransitionCustom(
              page: OtpScreen(
                screenName: "login",
                userId: value["id"].toString(),
                otp: value["otp"].toString(),
              ),
            ),
          );
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      print(ex.code);
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

// user Login

  // otp verify
  verifyOtp(
      {required context,
      required userId,
      required otp,
      required screenName}) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.OTP_VERIFY, context, body: {
        "id": userId,
        "otp": otp,
      }).then((dynamic value) async {
        Loader.hide();
        if (value["status"] == "true") {
          if (screenName == "forgot") {
            Navigator.pushReplacement(
              context,
              PageTransitionCustom(
                page: NewPasswordScreen(
                  userId: userId,
                ),
              ),
            );
          } else if (screenName == "login") {
            await SharedPreferencesUtility.setString(
                "userData", json.encode(value["data"]));
            await SharedPreferencesUtility.setBool("isLogin", true);
            Navigator.pushAndRemoveUntil(
              context,
              PageTransitionCustom(
                page: const BottomNavigationScreen(),
              ),
              (route) => false,
            );
          } else if (screenName == "register") {
            CommonHelper.flutterToast(context, "Register Succesfully!");
            Navigator.pushAndRemoveUntil(
              context,
              PageTransitionCustom(
                page: const SignInScreen(),
              ),
              (route) => false,
            );
          }
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

  resendOtp({
    required context,
    required userId,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.OTP_RESEND, context, body: {
        "id": userId,
      }).then((dynamic value) async {
        Loader.hide();
        CommonHelper.flutterToast(context, value["otp"].toString(),
            position: StyledToastPosition.center);
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

// otp verify

//forgot email check
  forgotEmailCheck({
    required context,
    required email,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.FORGOT_PASSWORD, context, body: {
        "email": email,
      }).then((dynamic value) async {
        Loader.hide();
        if (value["status"] == "true") {
          Navigator.push(
            context,
            PageTransitionCustom(
              page: OtpScreen(
                screenName: "forgot",
                userId: value["id"].toString(),
                otp: value["otp"].toString(),
              ),
            ),
          );
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

//forgot email check

//forgot update password
  updatePassword({
    required context,
    required id,
    required newpass,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    try {
      await ApiHandler.post(Config.FORGOT_UPDATE_PASSWORD, context, body: {
        "id": id,
        "newpass": newpass,
      }).then((dynamic value) async {
        Loader.hide();
        if (value["status"] == "true") {
          CommonHelper.flutterToast(context, value["message"]);
          Navigator.pushAndRemoveUntil(
            context,
            PageTransitionCustom(
              page: const SignInScreen(),
            ),
            (route) => false,
          );
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

//forgot update password

//forgot update password
  changePassword({
    required context,
    required oldpass,
    required newpass,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    String? userId = await CommonHelper.getUserId();
    try {
      await ApiHandler.post(Config.CHANGE_PASSWORD, context, body: {
        "id": userId!,
        "oldpass": oldpass,
        "newpass": newpass,
      }).then((dynamic value) async {
        Loader.hide();
        if (value["status"] == "true") {
          CommonHelper.flutterToast(context, value["message"]);
          Navigator.pop(context);
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

//forgot update password

//edit profile
  editProfile({
    required context,
    required username,
    required contact,
    required email,
    required image,
  }) async {
    Loader.show(context, progressIndicator: customLoader);
    String? userId = await CommonHelper.getUserId();
    try {
      await ApiHandler.postWithFile1(
        Config.UPDATE_PROFILE,
        context,
        body: {
          "id": userId!,
          "username": username,
          "contact": contact,
          "email": email,
        },
        imageField: "image",
        imageName: image,
      ).then((dynamic value) async {
        Loader.hide();
        if (value["status"] == "true") {
          await SharedPreferencesUtility.setString("userData", json.encode(value["data"]));
          CommonHelper.flutterToast(context, value["message"]);
          Navigator.pop(context);
          profileScreenState.refreshdata();
        } else {
          CommonHelper.flutterToast(context, value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      CommonHelper.flutterToast(context, ex.message,
          color: ColorRes.redColor, fontColor: ColorRes.whiteColor);
      Loader.hide();
    }
  }

//edit profile

// Device information
  _getId(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
// Device information
}
