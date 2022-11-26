import 'dart:io';
import 'dart:typed_data';

import 'package:nearvegi/constants/constraints.dart';
import 'package:nearvegi/constants/initdata.dart';
import 'package:nearvegi/models/usermodel.dart';

import 'package:nearvegi/screens/auth/sign_in.dart';
import 'package:nearvegi/services/auth/signin_mannager.dart';
import 'package:nearvegi/services/date_time/date.dart';
import 'package:nearvegi/services/firebase/fb_handeler.dart';
import 'package:nearvegi/services/upload/file_upload.dart';

import 'package:nearvegi/services/validator/validate_handeler.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../components/already_have_an_account_acheck.dart';
import '../components/or_divider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = "";
  String _passWord = "";
  String _name = "";
  String _mobile = "";
  String _city = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  final TextEditingController _namecon = TextEditingController();
  final TextEditingController _mobilecon = TextEditingController();
  final TextEditingController _citycon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kGradientGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hello !! ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: size.height * 0.01),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: size.width * 0.25,
                              width: size.height * 0.12,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  isimgload
                                      ? CircleAvatar(
                                          radius: size.width * 0.17,
                                          backgroundImage:
                                              FileImage(File(_image!.path)),
                                        )
                                      : CircleAvatar(
                                          radius: size.width * 0.17,
                                          backgroundImage: const AssetImage(
                                              "assets/icons/farmer.png"),
                                        ),
                                  Positioned(
                                      bottom: 0,
                                      right: -25,
                                      child: RawMaterialButton(
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          _imgFromGallery();
                                        },
                                        elevation: 2.0,
                                        fillColor: const Color(0xFFF5F6F9),
                                        padding: const EdgeInsets.all(5.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.green,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(85, 25, 167, 17),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _namecon,
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Name *",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _citycon,
                                      onChanged: (value) {
                                        _city = value;
                                      },
                                      validator: (value) {
                                        return Validater.genaralvalid(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "City *",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _mobilecon,
                                      onChanged: (value) {
                                        _mobile = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildmobile(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Mobile No *",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _pwcon,
                                      onChanged: (value) {
                                        _passWord = value;
                                      },
                                      validator: (value) {
                                        return Validater.signupPassword(value!);
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: _viewPassword,
                                              child:
                                                  const Icon(Icons.visibility)),
                                          hintText: "Password *",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  // print("press login");
                                  // _scaffoldKey.currentState!
                                  //     // ignore: deprecated_member_use
                                  //     .showSnackBar(SnackBar(
                                  //   duration: const Duration(seconds: 4),
                                  //   backgroundColor: kPrimaryColordark,
                                  //   content: Row(
                                  //     children: const <Widget>[
                                  //       CircularProgressIndicator(),
                                  //       Text("Registering...")
                                  //     ],
                                  //   ),
                                  // ));
                                  // print(_email.trim());
                                  // print(_passWord);

                                  // int r = await SigninManager()
                                  //     .signUp(_email.trim(), _passWord);

                                  // if (r == resok) {
                                  //   String iurl = await _imageUpload();
                                  //   final user =
                                  //       FirebaseAuth.instance.currentUser;
                                  //   final umodel = UserModel(
                                  //       uid: user!.uid,
                                  //       name: _namecon.text,
                                  //       email: _uncon.text,
                                  //       phone: _mobilecon.text,
                                  //       area: _citycon.text,
                                  //       imageurl: iurl,
                                  //       role: UserRole.farmer.index.toString(),
                                  //       date: DateTime.now().toIso8601String());
                                  //   await FbHandeler.createDocManual(
                                  //       umodel.toMap(),
                                  //       CollectionPath.userpath,
                                  //       user.uid);
                                  //   // ignore: use_build_context_synchronously
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) {
                                  //         return const CheckSignIn();
                                  //       },
                                  //     ),
                                  //   );
                                  //   print(r);
                                  // } else if (r == resfail) {
                                  //   Get.snackbar(
                                  //     "SignUp failed",
                                  //     "Please enter the valid email or password",
                                  //     icon: const Icon(Icons.error,
                                  //         color: Colors.white),
                                  //     snackPosition: SnackPosition.BOTTOM,
                                  //   );
                                  // } else if (r == 2) {
                                  //   Get.snackbar(
                                  //     "SignUp failed",
                                  //     "Please enter the valid email or password",
                                  //     colorText: Colors.red,
                                  //     backgroundColor: Colors.yellow,
                                  //     icon: const Icon(Icons.error,
                                  //         color: Colors.black),
                                  //     snackPosition: SnackPosition.TOP,
                                  //   );
                                  // }
                                } else {
                                  print("Not Complete");
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: kPrimaryColordark),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            OrDivider(),
                            AlreadyHaveAnAccountCheck(
                              login: false,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignIn();
                                    },
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isHidepassword = true;
  void _viewPassword() {
    if (isHidepassword == true) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool isimgload = false;

  Future<void> _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        isimgload = true;
      });
    }
  }

  Future<String> _imageUpload() async {
    String imgurl = guserimg;
    print(isimgload.toString() + "----------------------------------------");
    if (isimgload) {
      Uint8List imgunitfile = await _image!.readAsBytes();
      String imgid = Date.getDateTimeId();

      imgurl =
          await FileUploader.uploadImage(imgunitfile, userimagebucket, imgid);
    } else {
      imgurl = guserimg;
    }
    print(imgurl);
    return imgurl;
  }
}
