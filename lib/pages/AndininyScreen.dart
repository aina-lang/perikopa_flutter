import 'dart:math';

import 'package:flutter/material.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/pages/showVerse.dart';

class AndininyScreen extends StatefulWidget {
  final String nomLivre;
  final String toko;
  const AndininyScreen({Key? key, required this.nomLivre, required this.toko})
      : super(key: key);

  @override
  State<AndininyScreen> createState() => _AndininyScreenState();
}

class _AndininyScreenState extends State<AndininyScreen> {
  int? andininyCount ;

  int selectedButtonIndex = 0;
  
  late String titleLivre=""; // Track the selected button index

  @override
  void initState() {
    super.initState();
    fetchandininyCount(widget.nomLivre);
  }

  Future<void> fetchandininyCount(String nomLivre) async {
    int distinctAndinnyValues = await DBHelper.getAndininyCountForToko(
        widget.nomLivre, widget.toko);
titleLivre = await DBHelper.getNomLivre(widget.nomLivre);
    setState(() {
      andininyCount = distinctAndinnyValues;
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
                  "$titleLivre ${widget.toko}",
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
              "SAFIDIO NY Andininy",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SHowVerse(
                                  nomLivre: widget.nomLivre,
                                  toko: widget.toko,
                                  andininy: (index+1).toString(),
                                )),
                      );
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ?  Theme.of(context).colorScheme.primary
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
                          (index+1).toString(),
                          style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  :  Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  );
                },
                childCount: andininyCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
