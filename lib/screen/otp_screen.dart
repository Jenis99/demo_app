import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/bottom_Navigation_screen.dart';
import 'package:wakiewakie/screen/new_password_screen.dart';
import 'package:wakiewakie/screen/signin_screen.dart';
import 'package:wakiewakie/screen/signup_screen.dart';

import '../resources/color_resourse.dart';
import '../resources/elevated_button_custom.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';

class OtpScreen extends StatefulWidget {
  final String screenName;
  final String userId;
  final String otp;
  final String mobileNo;

  const OtpScreen(
      {Key? key,required this.userId,required this.screenName, this.otp = "", this.mobileNo = "", })
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpTxtcontroller = TextEditingController();
  late Notifier notifier;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CommonHelper.flutterToast(context, widget.otp);
    });
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<Notifier>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: ColorRes.whiteColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragStart: (val) {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        ImageRes.logo,
                        width: 185,
                        height: 125,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextCustom(
                      text: "OTP Verification",
                      color: ColorRes.primaryColor,
                      fontFamily: StringRes.fontPoppins,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextCustom(
                              text:
                                  "An OTP has been sent to your registered mobile number ${widget.mobileNo}",
                              color: ColorRes.blackCusColor,
                              fontFamily: StringRes.fontSofiaPro,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            TextCustom(
                              text: "Enter OTP Here",
                              color: ColorRes.blackCusColor,
                              fontFamily: StringRes.fontSofiaPro,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            TextFormFieldCustom(
                              textController: otpTxtcontroller,
                              hintText: "OTP Here",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: "Didn't receive the code? ",
                                  color: ColorRes.blackCusColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                TextCustom(
                                  text: "Resend code",
                                  color: ColorRes.primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  onPressed: () async{
                                    await notifier.resendOtp(
                                      context: context,
                                      userId: widget.userId,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ButtonCustom(
                        titleText: 'VERIFY',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            await notifier.verifyOtp(
                              context: context,
                              userId: widget.userId,
                              otp: otpTxtcontroller.text,
                              screenName: widget.screenName,
                            );
                          }
                        },
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
}
