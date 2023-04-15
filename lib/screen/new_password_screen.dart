import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/otp_screen.dart';
import 'package:wakiewakie/screen/signin_screen.dart';
import 'package:wakiewakie/screen/signup_screen.dart';

import '../resources/color_resourse.dart';
import '../resources/elevated_button_custom.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';
import 'bottom_Navigation_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String userId;
  const NewPasswordScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var passwordTxtcontroller = TextEditingController();
  var confirmPasswordTxtcontroller = TextEditingController();
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
                      text: "New Password",
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
                              textController: passwordTxtcontroller,
                              hintText: "New Password",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            TextFormFieldCustom(
                              textController: confirmPasswordTxtcontroller,
                              hintText: "Re-type New Password",
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ButtonCustom(
                              titleText: 'CONTINUE',
                              onPressed: () async{
                                FocusScope.of(context).unfocus();
                                if (formKey.currentState!.validate()) {
                                  if(passwordTxtcontroller.text==confirmPasswordTxtcontroller.text){
                                    await notifier.updatePassword(
                                      context: context,
                                      id: widget.userId,
                                      newpass: passwordTxtcontroller.text.trim(),
                                    );
                                  }else{
                                    CommonHelper.flutterToast(context, "Password and Confirm Password Doesn't match");
                                  }
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
        ),
      ),
    );
  }
}
