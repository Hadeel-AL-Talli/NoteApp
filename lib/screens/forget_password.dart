import 'package:firebaseapp/controllers/fb_auth_controller.dart';
import 'package:firebaseapp/helpers/helpers.dart';
import 'package:firebaseapp/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helpers {
  late TextEditingController _emailTextController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
       body: ListView(
         physics: const NeverScrollableScrollPhysics(),
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         children: [
           const Text(
             'Please Enter your Email',
             style: TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
               fontFamily: 'Din',
               fontSize: 18,
             ),
           ),
           const Text(
             'Activation code will be send ',
             style: TextStyle(
               color: Colors.grey,
               fontSize: 14,
               fontFamily: 'Din'
             ),
           ),
           const SizedBox(height: 15),
           CustomTextFeild(

              _emailTextController,

           ),
           const SizedBox(height: 15),
           ElevatedButton(
             onPressed: () async {
               //TODO: Perform forget password function

               await performForgetPassword();
             },
             child: const Text('Send', style: TextStyle(fontFamily: 'Din', fontSize: 18),),
             style: ElevatedButton.styleFrom(
               primary: Color(0xff3930D8),
               minimumSize: const Size(0, 50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
             ),
           ),
         ],
       ),
    );
  }


  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await FBAuthController()
        .forgetPassword(context: context, email: _emailTextController.text);
    if (status) {
      Navigator.pop(context);
    }
  }
}
