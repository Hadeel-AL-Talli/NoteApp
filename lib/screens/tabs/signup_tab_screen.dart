import 'package:firebaseapp/controllers/fb_auth_controller.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:firebaseapp/widgets/custom_button.dart';
import 'package:firebaseapp/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTabScreen extends StatefulWidget {
  const SignUpTabScreen({Key? key}) : super(key: key);

  @override
  _SignUpTabScreenState createState() => _SignUpTabScreenState();
}

class _SignUpTabScreenState extends State<SignUpTabScreen>  with Helpers{
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

      children: [
       Image.asset('images/login.png', width: 150, height: 200,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(' Please fill in the following information',style: TextStyle(color: Color(0xff3930D8) , fontSize: 20 , fontFamily: 'Din', fontWeight: FontWeight.bold),),
        ),
        Text('Email ',  style: TextStyle(fontFamily: 'Din' , color: Color(0xff3930D8)),),

        CustomTextFeild(_emailTextEditingController),
        Text('Password  ', style: TextStyle(fontFamily: 'Din' , color: Color(0xff3930D8)),),

        CustomTextFeild(_passwordTextEditingController),
        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(onPress: ()async=> await performRegister(), text: 'Sign up ', color: Color(0xff3930D8)),
        ),
      ],
    );
  }
Future<void> performRegister() async{
    if(checkDate()){
      await register();
    }
}
bool checkDate(){
if(_emailTextEditingController.text.isNotEmpty
    && _passwordTextEditingController.text.isNotEmpty){
  return true;
}
showSnackBar(context: context, message: 'Enter required Data');
return false;
}

Future<void> register () async{
bool status = await FBAuthController().createAccount(context: context, email: _emailTextEditingController.text, password: _passwordTextEditingController.text);
if(status){
  Navigator.pop(context);
}
}
}
