import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nearvegi/constants/constraints.dart';
import 'package:nearvegi/models/usermodel.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColordark,
        elevation: 0,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.02,
                      left: size.width * 0.15,
                      right: size.width * 0.15),
                  child: Image.asset("assets/icons/app_icon.png")),
              Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  child: Text(
                    "Smart Fair  offer tools for fostering stronger relationships between buyers and sellers of fresh vegetables and fruits. Customers of veggies and fruits can use this smart Fair app to connect with nearby sellers quickly. Using the mobile phone option and messaging provided by Smart Fair, customers may communicate with nearby sellers.",
                    style: TextStyle(
                      fontSize: size.width * 0.039,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
