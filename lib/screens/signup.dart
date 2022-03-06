import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'login.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  
  //Creating Method for Sending Data on Api Server
  void register(String email, password, fullName, phoneNumber, username)async{
    try{
      var response = await post(Uri.parse('http://codebase.pk:8800/api/register/'),
      body: {
        "email": email,
        "password": password,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "username": username,
      });
      if(response.statusCode == 201){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Account Created successfully");
      }else{
        print("Failed");
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
        title: Text("Sign Up Screen"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20),
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
                "Register Yourself !",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
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
            SizedBox(height: 10.0),
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
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: fullNameController,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Name";
                  } else if(val.toString().length < 3){
                    return "Name is too small";
                  } else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Full Name",
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.edit),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  return RegExp(
                    "^[0-9]{4}-[0-9]{7}",
                  ).hasMatch(val!)
                      ? null
                      : 'Format XXXX-XXXXXXX';
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Mobile Number",
                  labelText: "Mobile Number",
                  prefixIcon: Icon(Icons.edit),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: userNameController,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Username";
                  } else if(val.toString().length < 3){
                    return "Name is too small";
                  } else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Username",
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
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
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.4,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          return   register(
                            emailController.text.toString(),
                            passwordController.text.toString(),
                            fullNameController.text.toString(),
                            phoneNumberController.text.toString(),
                            userNameController.text.toString(),
                          );
                        } else{
                          return null;
                        }
                      }, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.4,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=> SignInScreen()));
                      }, icon: Icon(Icons.arrow_forward, color: Colors.white,)),
                )
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       // onTap: () {
            //       //   Navigator.pushReplacement(
            //       //       context, MaterialPageRoute(builder: (ctx) => ));
            //       // },
            //       child: Container(
            //         padding: EdgeInsets.only(bottom: 4.0),
            //         decoration: BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(
            //                   color: Colors.purple,
            //                   width: 2.3,
            //                 ))),
            //         child: Text(
            //           "Sign Up",
            //           style: TextStyle(
            //             color: Colors.deepPurple,
            //             fontWeight: FontWeight.w700,
            //             fontSize: 16,
            //             letterSpacing: 0.4,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.only(bottom: 4.0),
            //       decoration: BoxDecoration(
            //           border: Border(
            //               bottom: BorderSide(
            //                 color: Colors.purple,
            //                 width: 2.3,
            //               ))),
            //       child: Text(
            //         "Forgot Password?",
            //         style: TextStyle(
            //           color: Colors.deepPurple,
            //           fontWeight: FontWeight.w700,
            //           fontSize: 16,
            //           letterSpacing: 0.4,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
