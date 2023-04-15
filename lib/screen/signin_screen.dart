import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/signup_screen.dart';

import '../resources/color_resourse.dart';
import '../resources/elevated_button_custom.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';
import 'bottom_Navigation_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailTxtcontroller = TextEditingController();
  var passwordTxtcontroller = TextEditingController();
  late Notifier notifier;
  var formKey = GlobalKey<FormState>();

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
                      text: "Sign In",
                      color: ColorRes.primaryColor,
                      fontFamily: StringRes.fontPoppins,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormFieldCustom(
                                textController: emailTxtcontroller,
                                hintText: "Email",
                                validator: CommonHelper.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormFieldCustom(
                              textController: passwordTxtcontroller,
                              hintText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextCustom(
                                text: "Forgot your Password?",
                                color: ColorRes.blackCusColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransitionCustom(
                                          page: ForgotPasswordScreen()));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            ButtonCustom(
                              titleText: 'SIGN IN',
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  String? notiToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  await notifier.login(
                                    context: context,
                                    email: emailTxtcontroller.text.trim(),
                                    password: passwordTxtcontroller.text.trim(),
                                    notificationtoken: notiToken!,
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustom(
                                  text: "Don't Have an Account? ",
                                  color: ColorRes.blackCusColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                                TextCustom(
                                  text: "Sign Up",
                                  color: ColorRes.primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransitionCustom(
                                        page: const SignUpScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
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
}
