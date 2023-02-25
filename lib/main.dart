import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screen/Sign_in.dart';
import 'package:flash_chat/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),

  ));
}
