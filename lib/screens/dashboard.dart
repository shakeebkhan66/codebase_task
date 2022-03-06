import 'package:codebase_task/screens/login.dart';
import 'package:codebase_task/utils/shared_preference_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: (){
                Constants.preferences!.setBool("loggedIn", false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx)=> SignInScreen()));
              },
              icon: Icon(Icons.logout, color: Colors.white, size: 20,),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
        ],
      ),
    );
  }
}
