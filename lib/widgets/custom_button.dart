import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  Color color ;
  Function onPress;
  CustomButton({
    Key? key,
    required this.onPress,
    required this.text,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          minimumSize: const Size(280, 60),
        ),
        onPressed: () {
          onPress();
        },
        child:  Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Din')));
  }
}