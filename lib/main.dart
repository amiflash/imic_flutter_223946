import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:view_and_layout_sample/entrances/models/user_info.dart';
import 'package:view_and_layout_sample/entrances/screens/home_screen.dart';
import 'package:view_and_layout_sample/entrances/screens/register_screen.dart';
import 'package:view_and_layout_sample/entrances/screens/welcome_screen.dart';
import 'package:view_and_layout_sample/providers/user_provider.dart';

import 'objectbox.dart';

late SharedPreferences pref;
late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref =  await SharedPreferences.getInstance();
  objectbox = await ObjectBox.create();

   final docsDir = await getApplicationDocumentsDirectory();

   print('doc dir: $docsDir');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {
  
  // This widget is the root of your application.

  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {

  Widget mainScreen = (userProvider.checkIfUserExisting()) ? HomeScreen() : WelcomeScreen();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  mainScreen,
    );
  }
}

