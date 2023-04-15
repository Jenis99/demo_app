import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakiewakie/model/user_model.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/screen/edit_profile_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/config.dart';
import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';

late _ProfileScreenState profileScreenState;
class ProfileScreen extends StatefulWidget {
  final bool isPop;
  const ProfileScreen({Key? key, this.isPop = false}) : super(key: key);

  @override
  State<ProfileScreen> createState() {
    profileScreenState = _ProfileScreenState();
    return profileScreenState;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshdata();
  }

  refreshdata() async{
    UserModel? user = await CommonHelper.getUserData();
    print(Config.USER_IMG_URL+(user.image??""));
    setState(() {
      this.user = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPop?AppBar(
        leading: IconButton(
          icon: Image.asset(ImageRes.ic_appbar_back,width: 24,height: 24,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextCustom(
            text: "Profile",
            letterSpacing: 1,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
      ):null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: CachedNetworkImage(
                                    imageUrl: user==null?"":Config.USER_IMG_URL+(user!.image??""),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(ImageRes.logo),
                                        ),
                                    progressIndicatorBuilder: (context, url, progress) => Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 14,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      text: user==null?"":(user!.username??"")+" "+(user!.lastname??""),
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 5,),
                                    TextCustom(
                                      text: user==null?"":(CommonHelper.calculateAge(user!.dob??"").toString()+" Old"),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            TextCustom(
                              text: "Edit",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(width: 8,),
                            InkWell(
                              onTap: (){
                                if(user!=null){
                                  Navigator.push(context, PageTransitionCustom(page: EditProfileScreen(user: user!,)));
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorRes.primaryColor,
                                ),
                                child: Icon(Icons.edit,color: Colors.white,size: 14,),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 36,),
                  TextCustom(
                    text: "Name",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5,),
                  TextCustom(
                    text: user==null?"":(user!.username??"")+" "+(user!.lastname??""),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(height: 17,),
                  Divider(color: ColorRes.greyColor,),
                  SizedBox(height: 21,),
                  TextCustom(
                    text: "Email",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5,),
                  TextCustom(
                    text: user==null?"":user!.email??"",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(height: 17,),
                  Divider(color: ColorRes.greyColor,),
                  SizedBox(height: 21,),
                  TextCustom(
                    text: "Phone Number",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5,),
                  TextCustom(
                    text: user==null?"":user!.contact??"",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(height: 17,),
                  Divider(color: ColorRes.greyColor,),
                ],
              ),
            ),
          ),
          if(user==null)Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }
}
