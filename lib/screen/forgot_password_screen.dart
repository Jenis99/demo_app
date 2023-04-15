import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/otp_screen.dart';
import 'package:wakiewakie/screen/signup_screen.dart';

import '../resources/color_resourse.dart';
import '../resources/elevated_button_custom.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';
import 'bottom_Navigation_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
          body: Stack(
            children: [
              GestureDetector(
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
                          text: "Forgot Password",
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
                                SizedBox(
                                  height: 16,
                                ),
                                ButtonCustom(
                                  titleText: 'CONTINUE',
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (formKey.currentState!.validate()) {
                                      await notifier.forgotEmailCheck(
                                        context: context,
                                        email: emailTxtcontroller.text.trim(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
