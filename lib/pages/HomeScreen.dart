// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:perikopa_flutter/models/MonthInfo.dart';
import 'package:perikopa_flutter/pages/Index.dart';
import 'package:perikopa_flutter/widgets/HomeHeader.dart';
import 'package:perikopa_flutter/widgets/HomeVerse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  final List<MonthInfo> months = [
    MonthInfo(
      name: 'Janvier',
      description: 'Ceci est janvier. C\'est le premier mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Février',
      description: 'Ceci est février. C\'est le deuxième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Mars',
      description: 'Ceci est mars. C\'est le troisième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Avril',
      description: 'Ceci est avril. C\'est le quatrième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Mai',
      description: 'Ceci est mai. C\'est le cinquième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Juin',
      description: 'Ceci est juin. C\'est le sixième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Juillet',
      description: 'Ceci est juillet. C\'est le septième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Août',
      description: 'Ceci est août. C\'est le huitième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Septembre',
      description: 'Ceci est septembre. C\'est le neuvième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Octobre',
      description: 'Ceci est octobre. C\'est le dixième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Novembre',
      description: 'Ceci est novembre. C\'est le onzième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
    MonthInfo(
      name: 'Décembre',
      description: 'Ceci est décembre. C\'est le douzième mois de l\'année.',
      imageUrl: 'assets/images/adult.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 230.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeHeader(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  // color: Theme.of(context).colorScheme.background,
                  // decoration: BoxDecoration(color: Color.fromARGB(255, 235, 239, 241)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Ity herinandro ity",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        HomeVerse()
                      ]),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: months.map((MonthInfo month) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteScreen(),
                              ),
                            );
                          },
                          child: Container(
                            // padding: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Color.fromARGB(192, 95, 94, 94),blurRadius: 2,offset: Offset(1,1),spreadRadius: 0.5)]
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(month.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      month.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      month.description,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
