// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perikopa_flutter/models/MonthInfo.dart';
import 'package:perikopa_flutter/pages/OneMonthScreen.dart';
import 'package:perikopa_flutter/widgets/HomeHeader.dart';
import 'package:perikopa_flutter/widgets/HomeVerse.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  var jsonData;

  @override
  void initState() {
    InitDataFromJson();
  }

  void InitDataFromJson() async {
    final String response =
        await rootBundle.loadString('assets/listPerikopa.json');
    final data = await json.decode(response);
    setState(() {
      jsonData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = DataModel.fromJson(jsonData);
    List<Month> allMonths = [
      ...dataModel.tronche1.mois,
      ...dataModel.tronche2.mois
    ];
    print(dataModel);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 230.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeHeader(
                faneva: dataModel.tenyFaneva,
                taona: dataModel.taona,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 20, bottom: 5, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ity herinandro ity",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            // Utilisez la date du premier mois
                            Text(
                              "05 - 26 ${allMonths[0].nom}  ${dataModel.taona}",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      HomeVerse(),
                    ],
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: allMonths.map((Month month) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OneMonthScreen(
                                  monthName: month.nom,
                                  faneva: month.faneva,
                                  // month
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(192, 95, 94, 94),
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                  spreadRadius: 0.5,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/adult.jpg"),
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
                                      month.nom,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      month.faneva,
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
