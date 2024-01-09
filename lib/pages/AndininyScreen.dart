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
  List<int> AndininyList = [];

  int selectedButtonIndex = 0; // Track the selected button index

  @override
  void initState() {
    super.initState();
    fetchAndininyList(widget.nomLivre);
  }

  Future<void> fetchAndininyList(String nomLivre) async {
    List<int> distinctAndinnyValues =
        await DBHelper.getDistinctNumeroAndininy(widget.nomLivre, widget.toko);

    setState(() {
      AndininyList = distinctAndinnyValues;
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
            backgroundColor: Color.fromRGBO(63, 81, 181, 1),
            foregroundColor: Colors.white,
            titleSpacing: -5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.nomLivre} ${widget.toko}",
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the home screen
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.home),
                  ),
                ),
              ],
            ),
          ),
          SliverAppBar(
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
            padding: EdgeInsets.all(20.0),
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
                                  andininy: AndininyList[index].toString(),
                                )),
                      );
                      setState(() {
                        selectedButtonIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color.fromRGBO(63, 81, 181, 1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x9f9a9a).withOpacity(0.26),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          AndininyList[index].toString(),
                          style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Color.fromRGBO(63, 81, 181, 1)),
                        ),
                      ),
                    ),
                  );
                },
                childCount: AndininyList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
