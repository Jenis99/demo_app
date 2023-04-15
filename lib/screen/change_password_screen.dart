import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/utility/common_helper.dart';

import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldpasswordTxtcontroller = TextEditingController();
  var newpasswordTxtcontroller = TextEditingController();
  var confirmPasswordTxtcontroller = TextEditingController();
  late Notifier notifier;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<Notifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(ImageRes.ic_appbar_back,width: 24,height: 24,),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 50,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextCustom(
            text: "Change Password",
            letterSpacing: 1,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (val){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormFieldCustom(
                          textController: oldpasswordTxtcontroller,
                          hintText: "Current Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        TextFormFieldCustom(
                          textController: newpasswordTxtcontroller,
                          hintText: "New Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        TextFormFieldCustom(
                          textController: confirmPasswordTxtcontroller,
                          hintText: "Re-type New Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    ButtonCustom(
                      titleText: "UPDATE PASSWORD",
                      onPressed: () async{
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          if(newpasswordTxtcontroller.text==confirmPasswordTxtcontroller.text){
                            await notifier.changePassword(
                              context: context,
                              newpass: newpasswordTxtcontroller.text.trim(),
                              oldpass: oldpasswordTxtcontroller.text.trim(),
                            );
                          }else{
                            CommonHelper.flutterToast(context, "Password and Confirm Password Doesn't match");
                          }
                        }
                      },
                    ),
                    SizedBox(height: 16,),
                    ButtonCustom(
                      titleText: "CANCEL",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // SizedBox(height: 16,),
                    // TextCustom(
                    //   text: "Forgot your Password",
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w300,
                    // ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
