import 'dart:async';

import 'package:firebaseapp/controllers/fb_auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  late StreamSubscription streamSubscription ;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration (seconds:3 ) ,(){
   streamSubscription =    FBAuthController().checkUserState(
          listener: ({required bool status})
      {
             String route = status ? '/home' : '/login_screen';
             Navigator.pushReplacementNamed(context, route);
      }
      );

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  alignment: Alignment.center,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
      colors: [

        Colors.white,
        Color(0xff3930D8),
      ],
    ),
  ),
  child: Container(
    child:  Image.asset('images/logo.png'),
  )
  ),

    );
  }
}
