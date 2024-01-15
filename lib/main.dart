// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:perikopa_flutter/config/ThemeProvider.dart";
import "package:perikopa_flutter/pages/SplashScreen.dart";
import "package:provider/provider.dart";

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: App()));
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perikopa",
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
