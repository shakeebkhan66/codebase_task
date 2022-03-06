import 'dart:convert';
import 'package:codebase_task/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class UserActivateScreen extends StatefulWidget {
  const UserActivateScreen({Key? key}) : super(key: key);

  @override
  _UserActivateScreenState createState() => _UserActivateScreenState();
}

class _UserActivateScreenState extends State<UserActivateScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  
  void myActivation(String email, emailOtp)async{
    try{
      var response = await post(Uri.parse('http://codebase.pk:8800/api/activate/'),
      body: {
        "email": email,
        "email_otp": emailOtp,      });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Account Created Successfully");
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
        title: Text("User Activate Account"),
      ),
      body: Column(
        children: [
          Text(
            "Here You Can",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 70,),
         TextFormField(
           controller: emailController,
           decoration: InputDecoration(
             hintText: "Enter Your Email Here",
             labelText: "Email",
             prefixIcon: Icon(Icons.email),
           ),
         ),
          SizedBox(height: 20,),
          TextFormField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter Your Otp Received in Your Email Here",
              labelText: "OTP",
              prefixIcon: Icon(Icons.edit),
            ),
          ),
          SizedBox(height: 80),
          MaterialButton(
            onPressed: (){
            myActivation(emailController.text.toString(), otpController.text.toString());
          },
          color: Colors.deepPurple,
          splashColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text("Submit", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}

