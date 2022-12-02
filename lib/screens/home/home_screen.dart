import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nearvegi/constants/constraints.dart';
import 'package:nearvegi/models/usermodel.dart';
import 'package:nearvegi/screens/ads/post_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, this.index = 0}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<UserModel> futureData;
  final user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 0;
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var userModel = Provider.of<UserModel>(context);

    return WillPopScope(
      onWillPop: () {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future<bool>.value(false);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: const Center(
          child: const PostTab(),
        ),
      ),
    );
  }
}
