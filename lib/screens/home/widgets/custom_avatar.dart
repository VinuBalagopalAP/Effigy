import 'package:effigy/screens/home/widgets/user_name.dart';
import 'package:effigy/common/user_profile_pic.dart';
import 'package:effigy/screens/logout/logout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogoutScreen(user: user),
              ),
            );
          },
          child: UserProfilePic(
            user: user,
            radius: 35,
          ),
        ),
        const SizedBox(height: 20),
        UserName(user: user),
      ],
    );
  }
}
