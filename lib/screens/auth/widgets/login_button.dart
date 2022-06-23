import 'package:effigy/common/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginGoogle extends StatelessWidget {
  const LoginGoogle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          // color: Colors.amber,
          width: displayWidth(context) * 0.3,
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: displayWidth(context) * 0.08,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SvgPicture.asset(
          'assets/google.svg',
          height: 50,
          width: 50,
        ),
      ],
    );
  }
}
