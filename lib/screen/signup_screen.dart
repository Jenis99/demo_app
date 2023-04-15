import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/otp_screen.dart';

import '../resources/color_resourse.dart';
import '../resources/elevated_button_custom.dart';
import '../resources/image_resourse.dart';
import '../resources/srting_resourse.dart';
import '../resources/textwidget_custom.dart';
import '../utility/common_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var firstNamecontroller = TextEditingController();
  var lastNameTxtcontroller = TextEditingController();
  var dobTxtcontroller = TextEditingController();
  var emailTxtcontroller = TextEditingController();
  var phoneNumberTxtcontroller = TextEditingController();
  var passwordTxtcontroller = TextEditingController();
  var confirmpasswordTxtcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late Notifier notifier;
  String selectedDob = "";

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
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageRes.logo,
                                  width: 185,
                                  height: 125,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                TextCustom(
                                  text: "Create Your Account",
                                  color: ColorRes.primaryColor,
                                  fontFamily: StringRes.fontPoppins,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  fontSize: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormFieldCustom(
                              textController: firstNamecontroller,
                              hintText: "Your Name",
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            TextFormFieldCustom(
                              textController: lastNameTxtcontroller,
                              hintText: "Last Name",
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            TextFormFieldCustom(
                              textController: dobTxtcontroller,
                              hintText: "Date Of Birth",
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    //get today's date
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                final formatDate = new DateFormat('yyyy-MM-dd');
                                final formatDate1 =
                                    new DateFormat('dd-MM-yyyy');
                                setState(() {
                                  dobTxtcontroller.text = formatDate1
                                      .format(pickedDate!)
                                      .toString();
                                  selectedDob = formatDate.format(pickedDate);
                                });
                              },
                              suffixIcon: ImageIcon(
                                AssetImage(
                                  ImageRes.ic_calendar,
                                ),
                                color: ColorRes.blackColor,
                              ),
                            ),
                            TextFormFieldCustom(
                              textController: emailTxtcontroller,
                              hintText: "Email",
                              validator: CommonHelper.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormFieldCustom(
                              textController: phoneNumberTxtcontroller,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.number,
                            ),
                            TextFormFieldCustom(
                              textController: passwordTxtcontroller,
                              hintText: "Password",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            TextFormFieldCustom(
                              textController: confirmpasswordTxtcontroller,
                              hintText: "Confirm Password",
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 21,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonCustom(
                      titleText: 'SIGN UP',
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          if(passwordTxtcontroller.text==confirmpasswordTxtcontroller.text){
                            String? notiToken = await FirebaseMessaging.instance.getToken();
                            await notifier.register(
                              context: context,
                              username: firstNamecontroller.text.trim(),
                              lastname: lastNameTxtcontroller.text.trim(),
                              contact: phoneNumberTxtcontroller.text.trim(),
                              email: emailTxtcontroller.text.trim(),
                              password: passwordTxtcontroller.text.trim(),
                              dob: selectedDob,
                              notificationtoken: notiToken!,
                            );
                            formKey.currentState!.reset();
                          }else{
                            CommonHelper.flutterToast(context, "Password and Confirm Password Doesn't match");
                          }

                        }
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCustom(
                          text: "Already have account? ",
                          color: ColorRes.blackCusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        TextCustom(
                          text: "Log In",
                          color: ColorRes.primaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
