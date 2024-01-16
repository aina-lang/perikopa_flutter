import 'dart:math';

import 'package:flutter/material.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/pages/AndininyScreen.dart';

class TokoScreen extends StatefulWidget {
  final String nomLivre;

  const TokoScreen({Key? key, required this.nomLivre}) : super(key: key);

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen> {
  List<String> tokoList = [];
  late String titleLivre = '';
  int selectedButtonIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchTokoList(widget.nomLivre);
  }

  void fetchTokoList(String nomLivre) async {
    List<String> distinctTokoValues =
        await DBHelper.getDistinctTokoValues(widget.nomLivre);
    titleLivre = await DBHelper.getNomLivre(widget.nomLivre);
    setState(() {
      tokoList = distinctTokoValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = max((screenWidth / 100).floor(), 4);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor:  Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            titleSpacing: -5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 titleLivre,
                  style: const TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the home screen
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ),
          const SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "SAFIDIO NY TOKO",
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
            titleSpacing: 10,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  bool isSelected = selectedButtonIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedButtonIndex = index;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AndininyScreen(
                                nomLivre: widget.nomLivre,
                                toko: tokoList[index])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x009f9a9a).withOpacity(0.26),
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          tokoList[index],
                          style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  :  Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  );
                },
                childCount: tokoList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
