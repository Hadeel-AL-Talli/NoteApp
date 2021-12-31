import 'package:firebaseapp/controllers/fb_auth_controller.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:firebaseapp/widgets/custom_button.dart';
import 'package:firebaseapp/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTabScreen extends StatefulWidget {
  const LoginTabScreen({Key? key}) : super(key: key);

  @override
  _LoginTabScreenState createState() => _LoginTabScreenState();
}

class _LoginTabScreenState extends State<LoginTabScreen>  with Helpers{
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
         physics: BouncingScrollPhysics(),
      children: [
           Image.asset('images/login.png' , height: 200, width: 150,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(' Welcome back ... ', style: TextStyle(color: Color(0xff3930D8) , fontSize: 24 , fontFamily: 'Din', fontWeight: FontWeight.bold),),
        ),
        Text('Email', style: TextStyle(fontFamily: 'Din' , color: Color(0xff3930D8) ),),

        CustomTextFeild(_emailTextEditingController),
        Text(' password ',  style: TextStyle(fontFamily: 'Din' , color: Color(0xff3930D8)),),

        CustomTextFeild(_passwordTextEditingController),
        //SizedBox(height: 20,),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/forget_password');
        }, child: Text('Forget password ? ' ,style: TextStyle(fontSize: 16 , fontFamily: 'Din' , color: Color(0xff3930D8)),)),
       // SizedBox(height: 30,),

        
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(onPress: () async=> await performLogin(), text: 'Login', color: Color(0xff3930D8)),
        ),
      ],
    );
  }
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }


Future<void> login () async{
bool status = await FBAuthController().signIn(context: context, email: _emailTextEditingController.text, password: _passwordTextEditingController.text);

if(status){
  Navigator.pushReplacementNamed(context, '/home');
}
}
}
