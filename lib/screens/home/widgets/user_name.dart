import 'package:effigy/common/sizes_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class UserName extends StatelessWidget {
  const UserName({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return RichText(
      // Controls visual overflow
      overflow: TextOverflow.clip,

      // Controls how the text should be aligned horizontally
      textAlign: TextAlign.end,

      // Control the text direction
      textDirection: TextDirection.rtl,

      // Whether the text should break at soft line breaks
      softWrap: true,

      // Maximum number of lines for the text to span
      maxLines: 2,

      // The number of font pixels for each logical pixel
      textScaleFactor: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Welcome',
            style: TextStyle(
              fontSize: displayWidth(context) * 0.055,
              fontWeight: FontWeight.w500,
              color: HexColor("#C30B2D"),
            ),
          ),
          TextSpan(
            text: '\n${user.displayName!}',
            style: TextStyle(
              fontSize: displayWidth(context) * 0.06,
              fontWeight: FontWeight.w600,
              color: HexColor("#7F0BE0"),
            ),
          ),
        ],
      ),
    );
  }
}
