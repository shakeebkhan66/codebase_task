import 'dart:async';

import 'package:codebase_task/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (ctx)=> SignInScreen())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/co.png"),
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Text(
                "Welcome To The",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  fontSize: 27)
              ),
            ),
          ],
        ),
      )
    );
  }
}
