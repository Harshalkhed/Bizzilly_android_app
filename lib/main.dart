import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bizzilly/Screens/SplashScreen.dart';
import 'package:bizzilly/utilities/constants.dart';
import 'package:flutter/rendering.dart';

// Entry point of the application
void main()  {
  WidgetsFlutterBinding.ensureInitialized();  
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yellow Pages',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Raleway'),
      home: SplashScreen(),
    );
  }
}
