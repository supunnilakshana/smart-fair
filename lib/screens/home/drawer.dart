import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nearvegi/constants/constraints.dart';
import 'package:nearvegi/constants/initdata.dart';
import 'package:nearvegi/models/usermodel.dart';
import 'package:nearvegi/screens/ads/create_post.dart';
import 'package:nearvegi/screens/auth/sign_in.dart';
import 'package:nearvegi/screens/components/popup_dilog.dart';
import 'package:nearvegi/screens/drawer_items/aboutus_screen.dart';
import 'package:nearvegi/screens/drawer_items/contact_us.dart';
import 'package:nearvegi/screens/drawer_items/my_ads.dart';
import 'package:nearvegi/screens/drawer_items/privacy_screen.dart';
import 'package:nearvegi/screens/drawer_items/profile_page.dart';
import 'package:nearvegi/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../services/auth/signin_mannager.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    Key? key,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    var userModel = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColordark),
                accountEmail: Text(user!.email.toString()),
                accountName: Text("${userModel.name}"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      userModel.imageurl != "" ? userModel.imageurl : guserimg),
                )),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: kPrimaryColordark,
                ),
                title: const Text('Home'),
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.person_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('My Profile'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserProfileScreen(umodel: userModel)));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.create,
                  color: kPrimaryColordark,
                ),
                title: const Text('Create an Ad'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePostScreen()));
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.list_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('My Advertisement'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAdsScreen()));
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.web,
                  color: kPrimaryColordark,
                ),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutUsScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.contact_page_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Contact Us'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUsScreen()));
                },
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.book_online_outlined,
                  color: kPrimaryColordark,
                ),
                title: const Text('Privacy & Policy'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyScreen()));
                },
              ),
            ),

            Card(
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: kPrimaryColordark,
                ),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(
                      context, "Signout", "Do you want to signout ? ",
                      () async {
                    // context.read<UserModel>().updateData(UserModel(
                    //     name: "", email: "", phone: "", role: "-1", date: ""));

                    await SigninManager().signOut();

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                    print("logingout");
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustRoundedButton(
            //     height: size.height * 0.06,
            //     width: size.width * 0.25,
            //     text: "Logout",
            //     onpress: () async {
            //       // print(user.providerData[0].providerId);

            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
