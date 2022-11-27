import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nearvegi/screens/splash_screen/splash_screen.dart';
import 'package:nearvegi/test/test1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Fair',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: "title"),
    );
  }
}
