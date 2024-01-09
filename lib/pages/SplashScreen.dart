// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:perikopa_flutter/pages/Index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBInit {
  static bool _isInitialized = false;

  static Future<void> _initializeDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = "${dbDir}/perikopa.db";

    print(dbPath);
    await deleteDatabase(dbPath);

    ByteData data = await rootBundle.load("assets/perikopa.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(dbPath).writeAsBytes(bytes, flush: true);

    _isInitialized = true;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isDatabaseInitialized = DBInit._isInitialized;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    print("IS FIRSTIME : ${firstTime}");
    // ignore: no_leading_underscores_for_local_identifiers
    var _duration = const Duration(seconds: 2);

    if (firstTime != null && !firstTime) {
      // Not the first time
      print("IS FIRSTIME 1: ${firstTime}");
      prefs.setBool('first_time', true);
      setState(() {
        isDatabaseInitialized = true;
      });
      return Timer(_duration, navigationPageHome);
    } else {
      // First time
      print("IS FIRSTIME 2: ${firstTime}");
      DBInit._initializeDB();
      prefs.setBool('first_time', false);
      return Timer(_duration, navigationPageHome);
    }
  }

  void navigationPageHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Index()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: const Color.fromARGB(255, 248, 250, 251),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Positioned(
            //   top: MediaQuery.sizeOf(context).height * 0.5,
            //   // right: 60,
            //   child: Container(
            //     height: 5,
            //     width: 150,
            //     color: Color.fromRGBO(63, 81, 181, 1),
            //   ),
            // ),
            FadeAnimatedTextKit(
              repeatForever: true,
              text: const ["Perikopa",],
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(63, 81, 181, 1),
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.54,
              // left: 80,
              child: Container(
                height: 5,
                width: 150,
                color: Color.fromRGBO(63, 81, 181, 1),
              ),
            ),
            const SizedBox(height: 20),
            if (!isDatabaseInitialized) const CircularProgressIndicator()
          ],
        ),
      )),
    );
  }
}
