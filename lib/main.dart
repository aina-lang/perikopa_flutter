import "package:flutter/material.dart";
import "package:perikopa_flutter/pages/Index.dart";
import "package:perikopa_flutter/pages/SplashScreen.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Perikopa",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
