import 'package:flutter/material.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/screen/change_password_screen.dart';
import 'package:wakiewakie/screen/edit_profile_screen.dart';
import 'package:wakiewakie/screen/item/drawer_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';

import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerScreen(selectedIndex: 7,),
      appBar: AppBarCustom(title: "About us",scaffoldKey: scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Image.asset(
                ImageRes.logo,
                width: 185,
                height: 125,
              ),
              SizedBox(height: 20,),
              TextCustom(
                text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                color: ColorRes.homeTextColor,
                fontWeight: FontWeight.w300,
                fontSize: 14,
                height: 1.5,
                noMaxLines: false,
              ),
              TextCustom(
                text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                color: ColorRes.homeTextColor,
                fontWeight: FontWeight.w300,
                fontSize: 14,
                height: 1.5,
                noMaxLines: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
