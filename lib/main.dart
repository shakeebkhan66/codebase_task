import 'package:codebase_task/screens/activateScreen.dart';
import 'package:codebase_task/screens/dashboard.dart';
import 'package:codebase_task/screens/login.dart';
import 'package:codebase_task/screens/signup.dart';
import 'package:codebase_task/screens/splashscreen.dart';
import 'package:codebase_task/utils/shared_preference_const.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Constants.preferences = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "CodeBase Task",
    home: Constants.preferences!.getBool("loggedIn") == true ? DashboardScreen(): SplashScreen(),
  ));
}