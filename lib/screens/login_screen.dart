import 'package:firebaseapp/screens/tabs/login_tab_screen.dart';
import 'package:firebaseapp/screens/tabs/signup_tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('' , style: TextStyle(color: Colors.black),),
        backgroundColor:  Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Color(0xff3930D8),
          controller: _tabController,
          tabs: [

            Tab(
              child: Text(' Sign Up ' , style: TextStyle(color: Color(0xff3930D8) , fontFamily: 'Din' , fontWeight: FontWeight.bold),),
            ),
            Tab(

              child: Text('Login  ' , style: TextStyle(color: Color(0xff3930D8) , fontFamily: 'Din', fontWeight: FontWeight.bold),),

            ),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

        SignUpTabScreen(),
          LoginTabScreen(),
      ],),
    );
  }
}
