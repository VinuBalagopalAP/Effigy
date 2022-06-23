import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserProfilePic extends StatelessWidget {
  const UserProfilePic({
    Key? key,
    required this.user,
    required this.radius,
  }) : super(key: key);

  final User user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('#C30B2C'),
                HexColor('#790BF0'),
              ],
              stops: const [
                0.15,
                0.75,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated,
            ),
            // color: Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(200)),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(
                user.photoURL!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
