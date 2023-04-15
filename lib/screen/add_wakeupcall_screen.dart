import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/srting_resourse.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';

import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class AddWakeUpCallScreen extends StatefulWidget {
  const AddWakeUpCallScreen({Key? key}) : super(key: key);

  @override
  State<AddWakeUpCallScreen> createState() => _AddWakeUpCallScreenState();
}

class _AddWakeUpCallScreenState extends State<AddWakeUpCallScreen> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(ImageRes.ic_appbar_back,width: 24,height: 24,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextCustom(
            text: "Add Wakeup call",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: "Select Time",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.blackColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up,
                                        color: ColorRes.primaryColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextCustom(
                                        text: "08 h",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorRes.primaryColor,
                                      ),
                                    ],
                                  ),
                                  TextCustom(
                                    text: ":",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up,
                                        color: ColorRes.primaryColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextCustom(
                                        text: "30 m",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorRes.primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                TextCustom(
                                  text: "AM",
                                  fontSize: 18,
                                  color: ColorRes.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextCustom(
                                  text: "PM",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(
                            text: "Select Photo/smiley",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          TextCustom(
                            text: "😊",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.blackColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                              text: "Choose  Photo",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: ColorRes.primaryColor,
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.attach_file,color: ColorRes.whiteColor,),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextCustom(
                        text: "Repeat Alarm",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      DropdownButtonFormField(
                        items: <String>['Once', 'Repeat Daily']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: TextCustom(
                              text: value,
                              fontSize: 14,
                              color: ColorRes.homeTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                        value: 'Once',
                        onChanged: (val) {},
                        iconDisabledColor: ColorRes.blackColor,
                        iconEnabledColor: ColorRes.blackColor,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: StringRes.fontPoppins,
                              fontSize: 18),
                          hintStyle: TextStyle(
                              color: ColorRes.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextCustom(
                        text: "Add Voice",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      DropdownButtonFormField(
                        items: <String>[
                          'Ringtone 1',
                          'Ringtone 2',
                          'Ringtone 3',
                          'Ringtone 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: TextCustom(
                              text: value,
                              fontSize: 14,
                              color: ColorRes.homeTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                        value: 'Ringtone 1',
                        onChanged: (val) {},
                        iconDisabledColor: ColorRes.blackColor,
                        iconEnabledColor: ColorRes.blackColor,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: StringRes.fontPoppins,
                              fontSize: 18),
                          hintStyle: TextStyle(
                              color: ColorRes.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextCustom(
                        text: "Message",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      TextFormFieldCustom(
                        textController: TextEditingController(),
                        hintText: "Add your message",
                        margin: EdgeInsets.zero,
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ButtonCustom(
                          titleText: "CANCEL",
                          buttonColor: ColorRes.whiteColor,
                          textColor: ColorRes.primaryColor,
                          borderSide: BorderSide(color: ColorRes.primaryColor),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ButtonCustom(
                          titleText: "SAVE",
                          onPressed: () {},
                        ),
                      ),
                    ),
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
