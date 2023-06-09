import 'package:firebase_core/firebase_core.dart';
import 'package:firebasecrud/bordcast.dart';
import 'package:firebasecrud/firebase_options.dart';
import 'package:firebasecrud/intent.dart';
import 'package:firebasecrud/myapp.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600]),
    ),

    home:MyApp(),
    ),

  );

}