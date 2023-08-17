import 'package:FlutterVibes/localStorage/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:FlutterVibes/Pages/home.dart';
import 'package:FlutterVibes/firebase_options.dart';

import 'firebase/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MyFunctions().getAllSongs();
  final db=DatabaseHelper();
  await db.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
