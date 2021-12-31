import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  TextEditingController textEditingController;


  CustomTextFeild(this.textEditingController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(

        controller:textEditingController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(


          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xff3930D8),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
