import 'package:flutter/material.dart';
import 'package:perikopa_flutter/widgets/SearchSection.dart';

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
            color: const Color.fromARGB(255, 255, 255, 255),
          ),

          Container(
            height: screenHeight / 3,
            width: screenWidth,
            color: Color.fromRGBO(63, 81, 181, 1),
            // child: Image.asset(
            //   "assets/images/jesus.jpg",
            //   fit: BoxFit.cover,
            // ),
          ),

          Positioned(
            bottom: -20,
            right: -100,
            width: 280,
            child: Image.asset('assets/images/Regular_blob.png'),
          ),

          const Positioned(
            top: 50.0, // Position du titre
            left: 20.0,
            child: Text(
              "Perikopa",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow()
                ]
                // decoration:
              ),
            ),
          ),
          Positioned(
            top: 90,
            left: 20.0,
            child: SizedBox(
              width: screenWidth - 40.0, // Largeur du texte
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

          Positioned(bottom: 10, width: screenWidth, child: const SearchSection())
        ],
      ),
    );
  }
}