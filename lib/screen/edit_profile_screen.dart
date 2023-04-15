import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/config/config.dart';
import 'package:wakiewakie/model/user_model.dart';
import 'package:wakiewakie/notifiers/notifier.dart';
import 'package:wakiewakie/resources/color_resourse.dart';
import 'package:wakiewakie/resources/elevated_button_custom.dart';
import 'package:wakiewakie/resources/textformfield_custom.dart';
import 'package:wakiewakie/screen/profile_screen.dart';
import 'package:wakiewakie/utility/common_helper.dart';
import 'package:image_picker/image_picker.dart';
import '../resources/image_resourse.dart';
import '../resources/textwidget_custom.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel user = widget.user;
  File? userImage;
  var nameTxtcontroller = TextEditingController();
  var emailTxtcontroller = TextEditingController();
  var contactTxtcontroller = TextEditingController();
  late Notifier notifier;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTxtcontroller.text = (user.username??"")+" "+(user.lastname??"");
    emailTxtcontroller.text = user.email??"";
    contactTxtcontroller.text = user.contact??"";
  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<Notifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            ImageRes.ic_appbar_back,
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: TextCustom(
            text: "Edit Profile",
            letterSpacing: 1,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (val) {
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
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                              child: userImage == null
                                                  ? CachedNetworkImage(
                                                      imageUrl: Config
                                                              .USER_IMG_URL +
                                                          (user.image ?? ""),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Image.asset(
                                                            ImageRes.logo),
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    )
                                                  : Image.file(
                                                      userImage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                _pickImageDailog(context);
                                              },
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                decoration: BoxDecoration(
                                                  color: ColorRes.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: ColorRes.whiteColor,
                                                  size: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                            text: (user.username??"")+" "+(user.lastname??""),
                                            fontSize: 18,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextCustom(
                                            text: CommonHelper.calculateAge(
                                                  user.dob ?? "",
                                                ).toString() +
                                                " Old",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextCustom(
                            text: "Name",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldCustom(
                          textController: nameTxtcontroller,
                          margin: EdgeInsets.zero,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextCustom(
                            text: "Email",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldCustom(
                          textController: emailTxtcontroller,
                          margin: EdgeInsets.zero,
                          validator: CommonHelper.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextCustom(
                            text: "Phone Number",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormFieldCustom(
                          textController: contactTxtcontroller,
                          margin: EdgeInsets.zero,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonCustom(
                  titleText: "SAVE",
                  onPressed: () async{
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                        await notifier.editProfile(
                          context: context,
                          username: nameTxtcontroller.text,
                          email: emailTxtcontroller.text,
                          contact: contactTxtcontroller.text,
                          image: userImage==null?"":userImage!.path
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pickImageDailog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Navigator.of(context).pop();
                        pickImageForm(0);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      pickImageForm(1);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  pickImageForm(int index) async {
    XFile? pickedFile;
    pickedFile = await ImagePicker().pickImage(
      source: index == 0 ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 100,
    );
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 3),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        userImage = File(croppedFile.path);
      });
    }
  }
}
