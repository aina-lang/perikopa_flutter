import 'package:flutter/material.dart';
import 'package:perikopa_flutter/config/AppStyle.dart';
import 'package:perikopa_flutter/config/ThemeProvider.dart';
import 'package:perikopa_flutter/widgets/SearchSection.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

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
           
            decoration: BoxDecoration( color: Theme.of(context).colorScheme.primary,),
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
            child: Image.asset('assets/images/Regular_blob.png', fit: BoxFit.cover,),
          ),

          Positioned(
              top: 20,
              right: -100,
              width: 280,
              child: Switch(
                  trackOutlineWidth: MaterialStatePropertyAll(0),
                  value: false,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  })),
           Positioned(
            top: 50.0, // Position du titre
            left: 20.0,
            child: Text(
              "Perikopa",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                  shadows: [Shadow()]
                  // decoration:
                  ),
            ),
          ),
          Positioned(
            top: 90,
            left: 20.0,
            child: SizedBox(
              width: screenWidth - 40.0,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Dieu a tant aimé le monde qu'il a donné son Fils unique, afin que quiconque croit en lui ne périsse point, mais qu'il ait la vie éternelle. - Jean 3:16",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
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
