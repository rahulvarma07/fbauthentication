// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbauthentication/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final EmailController = TextEditingController();
  final PassWordController = TextEditingController();
  final ConformPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {

    bool showPass = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Sign up", style: TextStyle(color: Color(0xFFae4349),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  MyTextField("Email Address", EmailController, false),
                  SizedBox(height: 10,),
                  MyTextField("Password", PassWordController, true),
                  SizedBox(height: 10,),
                  MyTextField("Conform password", ConformPassword, true),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already a Member? "),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LoginPage()));
                          },
                          child: Text("Sign In", style: TextStyle(color: Color(
                              0xFFae4349), fontWeight: FontWeight.bold),))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        if(PassWordController.text.trim().length >= 6
                            && PassWordController.text == ConformPassword.text
                            && EmailController.text.trim().isNotEmpty
                        ){
                          CreateAccount();
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
                          child: Text("Sign up", style: TextStyle(color: Colors
                              .white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),),
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

  TextField MyTextField(String hintText, Controller, bool istrue) {
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

  Future<void> CreateAccount() async {
    // FirebaseAuth auth = await FirebaseAuth.instance;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: EmailController.text.trim(),
      password: EmailController.text.trim(),
    ).then((value){
      String name = EmailController.text.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SuccessFully created an account with $name")));
    }).onError((error, stackTrace){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }
}



class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double H = size.height;
    double W = size.width;
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(0, H*(1.5/5));
    path.quadraticBezierTo(W*(3/5), H+70, W, H*(3/5));
    path.lineTo(W, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}


class BottomCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double H = size.height;
    double W = size.width;
    Path path = Path();
    path.lineTo(0, H);
    path.lineTo(W, H);
    path.quadraticBezierTo(W*(4/5), H*(0.5/5), W*(2/5), H*(2/5));
    path.quadraticBezierTo(W*(1/5), H*(2.8/5), 0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
