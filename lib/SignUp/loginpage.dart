// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: Container(
                    color: Colors.lightBlue,
                  ),
                )
            ),
            Expanded(
              flex: 4,
                child: Container(
              color: Colors.grey,
            )),
            Expanded(
                flex: 1,
                child: Container(
              color: Colors.lightBlue,
            )),
          ],
        ),
      ),
    );
  }
}


class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double H = size.height;
    double W = size.width;
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(0, H*(1/5));
    path.quadraticBezierTo(0, H, W*(3), H);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}
