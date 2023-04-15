import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/srting_resourse.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';

import '../notifiers/notifier.dart';
import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  DateTime focusDate = DateTime.now();
  var titleTxtcontroller = TextEditingController();
  var messageTxtcontroller = TextEditingController();
  String SelectedDate = "";
  String SelectedTime = "";
  late Notifier notifier;
  var formKey = GlobalKey<FormState>();

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
            text: "Add reminder",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        TextCustom(
                          text: "Title",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TextFormFieldCustom(
                          textController: titleTxtcontroller,
                          hintText: "Add Tittle name",
                          margin: EdgeInsets.zero,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextCustom(
                          text: "Select Date",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.blackColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: ColorRes.blackColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: TableCalendar(
                              firstDay: DateTime.now(),
                              lastDay: DateTime.utc(2050, 3, 14),
                              focusedDay: DateTime.now(),
                              currentDay: focusDate,
                              calendarFormat: CalendarFormat.month,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (selectedDay, focusedDay) {
                                this.setState(() {
                                  focusDate = selectedDay;
                                });
                              },
                              rowHeight: 50,
                              calendarStyle: CalendarStyle(
                                holidayDecoration: BoxDecoration(
                                  color: ColorRes.primaryColor,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: ColorRes.primaryColor,
                                ),
                                rowDecoration: BoxDecoration(
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3),
                                ),
                                todayDecoration: BoxDecoration(
                                  color: ColorRes.primaryColor,
                                ),
                                defaultDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                markerDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                disabledDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                outsideDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                weekendDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                rangeEndDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                rangeStartDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                withinRangeDecoration: BoxDecoration(
                                  color: ColorRes.whiteColor,
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3)
                                ),
                                cellMargin: EdgeInsets.all(0),
                                defaultTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                todayTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.whiteColor,
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                holidayTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffaaaaaa),
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                weekendTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorRes.blackColor,
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                outsideTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffaaaaaa),
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                disabledTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffaaaaaa),
                                  fontFamily: StringRes.fontPoppins,
                                ),
                              ),
                              daysOfWeekHeight: 50,
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                weekendStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: StringRes.fontPoppins,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorRes.blackColor,width: 0.3),
                                ),
                              ),
                              headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleTextStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff2d2d2d),
                                    fontFamily: StringRes.fontPoppins,
                                  ),
                                  leftChevronIcon: Icon(Icons.arrow_back_ios),
                                  rightChevronIcon: Icon(Icons.arrow_forward_ios_outlined),
                                  titleCentered: true,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff3f3f3),
                                      border: Border.all(color: ColorRes.blackColor,width: 0.3),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                  ),
                                  headerPadding: EdgeInsets.zero,
                                  headerMargin: EdgeInsets.zero
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 27,
                        ),
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
                          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
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
                                          height: 16,
                                        ),
                                        TextCustom(
                                          text: "08 h",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 16,
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
                                          height: 16,
                                        ),
                                        TextCustom(
                                          text: "30 m",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(
                                          height: 16,
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
                                    height: 14,
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
                          height: 30,
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
                          height: 26,
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
                          height: 25,
                        )
                      ],
                    ),
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
