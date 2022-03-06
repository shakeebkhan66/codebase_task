import 'dart:convert';

import 'package:codebase_task/screens/dashboard.dart';
import 'package:codebase_task/screens/forgotPassword.dart';
import 'package:codebase_task/utils/shared_preference_const.dart';
import 'package:codebase_task/widgets/loading.dart';
import 'package:codebase_task/screens/signup.dart';
import 'package:codebase_task/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool isLoading = false;

  void login(String email, password)async{
    try{
      var response = await post(
          Uri.parse('http://codebase.pk:8800/api/login/'),
        body: {
        "email": email,
          "password": password,
        });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Login Successfully");
        setState(() => isLoading = true);
        Constants.preferences!.setBool("loggedIn", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> DashboardScreen()));
      }else{
        print("Failed");
      }
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() :
     Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Login Screen"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0, left: 20),
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
                "Login !",
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
                  hintText: "Enter Your Email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
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
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.4,
                  ),
                ),
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                      onPressed: () {
                           if(formKey.currentState!.validate()){
                             return login(emailController.text.toString(), passwordController.text.toString());
                           }
                           else{
                            return null;
                           }
                      }, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
                )
              ],
            ),
            SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.purple,
                      width: 2.3,
                    ))),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.purple,
                      width: 2.3,
                    ))),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
