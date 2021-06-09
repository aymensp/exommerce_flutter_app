import 'package:examen_2021/productDetails.dart';
import 'package:examen_2021/signin.dart';
import 'package:examen_2021/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomNav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefss = await SharedPreferences.getInstance();
  var token = prefss.getString('username');
  print(token);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoHire',
     
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: "/signin",
      routes: {
        "/": (BuildContext context) {
          return BottomNavigationInterface();
        },
        "/details": (BuildContext context) {
          return CarBooking();
        },
        
        "/signin": (BuildContext context) {
          return SignIn();
        },
        "/signup": (BuildContext context) {
          return UserAdd();
        },
      },
    );
  }
}