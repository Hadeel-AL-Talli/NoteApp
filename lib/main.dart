import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/bloc/bloc/storage_bloc.dart';
import 'package:firebaseapp/bloc/states/storage_states.dart';
import 'package:firebaseapp/screens/forget_password.dart';
import 'package:firebaseapp/screens/home_screen.dart';
import 'package:firebaseapp/screens/images/images_screen.dart';
import 'package:firebaseapp/screens/images/upload_image.dart';
import 'package:firebaseapp/screens/launch_screen.dart';
import 'package:firebaseapp/screens/login_screen.dart';
import 'package:firebaseapp/screens/note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StorageBloc>(create: (context)=> StorageBloc(LoadingState())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch_screen',
         routes: {
          '/launch_screen' :(context)=>LaunchScreen(),
          '/login_screen':(context)=> LoginScreen(),
           '/forget_password': (context)=> ForgetPassword(),
           '/home' : (context) => Home(),
          // '/note_screen' : (context)=> NoteScreen(),
           '/images_screen' : (context)=> ImagesScreen(),
           '/upload_image' :(context)=> UploadImage(),

         },
      ),
    );
  }
}

