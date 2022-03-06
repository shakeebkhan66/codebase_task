import 'dart:convert';

import 'package:codebase_task/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'login.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {


  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void changePassword(String email, otp, password) async{
    try{
      var response = await post(Uri.parse('http://codebase.pk:8800/api/change-password/'),
      body: {
        "email": email,
        "email_otp": otp,
        "new_password": password,
      });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print("Change Password Successfully");
      }else{
        print("Failed Operation");
      }
    }catch(e){
      print(e.toString());
    }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Change Password"),
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
                "Change Your Password !",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
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
                      hintText: "Enter Your Registered Email",
                      prefixIcon: Icon(Icons.email))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  validator: (val){
                    if(val!.isEmpty){
                      return "OTP is Required";
                    } else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Your Otp Received in Your Email",
                      prefixIcon: Icon(Icons.edit))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                  controller: passwordController,
                  validator: (val) {
                    if(val.toString().isEmpty){
                      return "Please Enter Your Password";
                    } else if(val.toString().length < 4){
                      return "Password is too small";
                    } else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Your New Password",
                      prefixIcon: Icon(Icons.lock))),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: MaterialButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    return changePassword(
                        emailController.text.toString(),
                        otpController.text.toString(),
                        passwordController.text.toString());
                  } else{
                    return null;
                  }
                },
                color: Colors.deepPurple,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
