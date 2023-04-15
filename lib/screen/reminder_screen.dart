import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wakiewakie/resources/textwidget_custom.dart';
import 'package:wakiewakie/screen/add_reminder_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';
import '../resources/color_resourse.dart';
import '../resources/image_resourse.dart';
import 'dart:math' as math;
import '../resources/srting_resourse.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late DateTime firstDay;
  late DateTime lastDay;
  late DateTime focusDate = DateTime.now();
  String displayDate = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayDate = format(focusDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 9,
          ),
          TextCustom(
            text: "Select Date",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorRes.homeTextColor,
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              border: Border.all(color: ColorRes.blackColor),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2050, 3, 14),
              focusedDay: focusDate,
              currentDay: focusDate,
              calendarFormat: CalendarFormat.week,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (selectedDay, focusedDay) {
                this.setState(() {
                  focusDate = selectedDay;
                  displayDate = format(focusDate);
                });
              },
              calendarStyle: CalendarStyle(
                holidayTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringRes.fontPoppins,
                ),
                holidayDecoration: BoxDecoration(
                  color: ColorRes.primaryColor
                ),
                todayDecoration: BoxDecoration(
                  color: ColorRes.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                defaultDecoration: BoxDecoration(
                  border: Border.all(color: ColorRes.greyColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                weekendDecoration: BoxDecoration(
                  border: Border.all(color: ColorRes.greyColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                outsideDecoration: BoxDecoration(
                  border: Border.all(color: ColorRes.greyColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                disabledDecoration: BoxDecoration(
                  border: Border.all(color: ColorRes.greyColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                defaultTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  fontFamily: StringRes.fontPoppins,
                ),
                todayTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: ColorRes.whiteColor,
                  fontFamily: StringRes.fontPoppins,
                ),
                weekendTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: ColorRes.blackColor,
                  fontFamily: StringRes.fontPoppins,
                ),
                outsideTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: ColorRes.greyColor,
                  fontFamily: StringRes.fontPoppins,
                ),
                disabledTextStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: ColorRes.greyColor,
                  fontFamily: StringRes.fontPoppins,
                ),
                cellMargin: EdgeInsets.symmetric(vertical: 12,horizontal: 7),
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
                  border: Border.all(color: ColorRes.blackColor),
                  borderRadius: BorderRadius.circular(10)
                ),
                headerPadding: EdgeInsets.zero,
                headerMargin: EdgeInsets.symmetric(horizontal: 0,vertical: 10)
              ),
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
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                        text: displayDate,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.homeTextColor,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, PageTransitionCustom(page: AddReminderScreen()));
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorRes.primaryColor,width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ImageIcon(
                              AssetImage(ImageRes.ic_plus),
                              color: ColorRes.primaryColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [1, 2, 3, 4, 5, 6].map((e) {
                      int colorint =
                          (math.Random().nextDouble() * 0xFFFFFF).toInt();
                      Color color = Color(colorint).withOpacity(0.8);
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text: "10:00 AM",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorRes.homeTextColor,
                            ),
                            Expanded(
                              child: Container(
                                height: 70,
                                margin: EdgeInsets.only(left: 28),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: color.withOpacity(0.3),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 17),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustom(
                                              text: "Dentist appointment today",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: color,
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            TextCustom(
                                              text:
                                                  "Lorem ipsum dolor sit amet, consetetur...",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: color,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 13, top: 10),
                                        child: ImageIcon(
                                          AssetImage(ImageRes.ic_more),
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  format(DateTime date) {
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return new DateFormat("MMM d'$suffix', yyyy").format(date);
  }
}
