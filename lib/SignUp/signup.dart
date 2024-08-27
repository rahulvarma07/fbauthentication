// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:fbauthentication/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final EmailController = TextEditingController();
  final PassWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool showPass = false;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          //Top Design
          Expanded(
              flex: 2,
              child: ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFe5a985),
                        Color(0xFFe5a985),
                        Color(0xFFaea396),
                        Color(0xFF8ab2a9),
                      ],
                    ),
                  ),
                ),
              )
          ),

          // Login Or Sign Up UI
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top:30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Sign in", style: TextStyle(color: Color(0xFFae4349), fontSize: 25, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  MyTextField("Email Address", EmailController, false),
                  SizedBox(height: 10,),
                  MyTextField("Password", PassWordController, true),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Not a Member? "),
                      GestureDetector(
                         onTap: (){
                           Navigator.pop(context);
                         },
                          child: Text("Sign Up", style: TextStyle(color: Color(0xFFae4349), fontWeight: FontWeight.bold),))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        if(EmailController.text.trim().isNotEmpty &&
                           PassWordController.text.trim().length >= 6
                           && PassWordController.text.trim().isNotEmpty
                        ){
                          CreatedAcc();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFFae4349),
                        ),
                        child: Center(
                          child: Text("Sign in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.apple, color: Colors.black, size: 50,),
                      SizedBox(width: 10,),
                      Icon(Icons.facebook, color: Colors.blue, size: 40,),
                      SizedBox(width: 10,),
                      Icon(Icons.phone, color: Colors.black, size: 34,)
                    ],
                  )
                ],
              ),
            ),
          ),

          // Bottom Design
          Expanded(
            flex: 2,
            child: ClipPath(
              clipper: BottomCustomClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFe14d57),
                      Color(0xFFf6b690),
                      Color(0xFFefcc96),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void>  CreatedAcc() async{
    // FirebaseAuth auth = await FirebaseAuth.instance;
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: EmailController.text.trim(), password: PassWordController.text.trim()
    ).then((value){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
    }).onError((err, stacktrace){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    });
}

  TextField MyTextField(String hintText, Controller, bool istrue){
    return TextField(
      controller: Controller,
      obscureText: istrue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        hintText: hintText,
      ),
    );
  }
}
