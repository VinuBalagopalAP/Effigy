import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EffigyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onpressed;

  const EffigyButton({
    Key? key,
    required this.child,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor('#C30B2C'),
              HexColor('#790BF0'),
            ],
            stops: const [0.15, 0.75],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: child,
      ),
    );
  }
}
