import 'package:flutter/material.dart';
import 'package:perikopa_flutter/config/AppStyle.dart';
import 'package:perikopa_flutter/config/ThemeProvider.dart';
import 'package:perikopa_flutter/widgets/SearchSection.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  final String faneva;
  final int taona;
  const HomeHeader({Key? key, required this.faneva, required this.taona})
      : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Transform(
          Container(
            height: screenHeight / 3 + 400,
            width: screenWidth,
            color: Theme.of(context).colorScheme.background,
          ),

          Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Image.asset(
              "assets/images/jesus.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: -30,
            right: -150,
            width: 350,
            // height: 500,
            child: Image.asset(
              'assets/images/Regular_blob.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 20,
            right: -100,
            width: 280,
            child: FutureBuilder<bool?>(
              future: Preference().getTheme(),
              builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                bool isDark = snapshot.data ?? false;
                return Switch(
                  trackOutlineWidth: MaterialStateProperty.all(0),
                  value: isDark,
                  onChanged: (value) async {
                    Preference().setTheme(value);
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 50.0, // Position du titre
            left: 20.0,
            child: Text(
              "Perikopa ${widget.taona}",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                  shadows: const [Shadow()]
                  // decoration:
                  ),
            ),
          ),
          Positioned(
            top: 90,
            left: 20.0,
            child: SizedBox(
              width: screenWidth - 40.0,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.faneva,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  )
                ],
              ),
            ),
          ),

          Positioned(
              bottom: 10, width: screenWidth, child: const SearchSection())
        ],
      ),
    );
  }
}
