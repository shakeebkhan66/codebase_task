import 'dart:convert';

import 'package:codebase_task/screens/changePassword.dart';
import 'package:codebase_task/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  
  void forgotPassword(String email) async{
    try{
      var response = await post(Uri.parse('http://codebase.pk:8800/api/forgot-password/'),
      body: {
        "email": email,
      });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Successfully Done");
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => ChangePasswordScreen()));
      }else{
        print("Failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Forgot Password"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 20),
              child: Text(
                "Here You Can",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
                "Enter Your Email For Forgot Password !",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(
              height: 55.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: emailController,
                validator: (val) {
                  return RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(val!)
                      ? null
                      : "Valid email required";
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Registered Email Here",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: MaterialButton(
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    return forgotPassword(emailController.text.toString());
                  }else {
                    return null;
                  }
                },
                color: Colors.deepPurple,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
