// ignore: file_names

import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/pages/AllBookScreen.dart';
import 'package:perikopa_flutter/widgets/BottomSheet.dart';

class SHowVerse extends StatefulWidget {
  final String toko;
  final String andininy;
  final String nomLivre;

  const SHowVerse({
    Key? key,
    required this.toko,
    required this.andininy,
    required this.nomLivre,
  }) : super(key: key);

  @override
  State<SHowVerse> createState() => _SHowVerseState();
}

class _SHowVerseState extends State<SHowVerse> {
  late int currentPage;
  late List<String?> andininyTexts = [];

  VoidCallback? _showBottomSheetCallback;
  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showPersistentBottomSheet;
    fetchAndininyText();
  }

  void fetchAndininyText() async {
    int tokoAsInt = int.tryParse(widget.toko) ?? 0;
    currentPage = tokoAsInt;
    int tokoId = await DBHelper.getTokoValue(widget.nomLivre, tokoAsInt);
    print("TOKO ID VENANT D'ici: $tokoId");
    List<String> andininyResult = await DBHelper.getAndininyTexts(tokoId);
    setState(() {
      andininyTexts = andininyResult;
    });
  }

  void incrementToko() {
    setState(() {
      currentPage++;
    });
  }

  void _showPersistentBottomSheet() {
    setState(() {
      _showBottomSheetCallback = null;
    });

    Scaffold.of(context)
        .showBottomSheet<void>((context) => const BottomSheetContent(),
            elevation: 25)
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          _showBottomSheetCallback = _showPersistentBottomSheet;
        });
      }
      {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //    PageView(
          // scrollDirection: Axis.horizontal,
          // children: [
          CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
            foregroundColor: Colors.white,
            titleSpacing: -5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.nomLivre} ${widget.toko} : $currentPage ",
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the home screen
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.home),
                      ),
                    ),
                    _buildPopupMenuButton(),
                  ],
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  // child: GestureZoomBox(
                  //   maxScale: 5.0,
                  //   doubleTapScale: 2.0,
                  child: InkWell(
                      overlayColor: MaterialStatePropertyAll(Colors.red),
                      hoverColor: Colors.red,
                      // textColor: Colors.grey[700],
                      // padding: const EdgeInsets.symmetric(horizontal: 0),
                      // onPressed: () {
                      //   print(index);
                      // },
                      child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 46, 46, 46)),
                          children: [
                            TextSpan(
                              text: "${index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue),
                            ),
                            const TextSpan(text: "   "),
                            TextSpan(
                              text: "${andininyTexts[index]}",
                              style: const TextStyle(height: 1.5),
                            )
                          ],
                        ),
                      )),
                  // )
                );
              },
              childCount: andininyTexts.length,
            ),
          ),
          // SliverToBoxAdapter(
          //   child:
          // ),
        ],
      ),
      //   ],
      // // )
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showPersistentBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        // Handle the selected value
        switch (value) {
          // Add more cases as needed
          case 1:
            // Handle the first action
            break;
          case 2:
            // Handle the second action
            break;
          // Add more cases as needed
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<int>(
            value: 1,
            child: const Text('Boky rehetra'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AllBookScreen()),
              );
            },
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text('Action 2'),
          ),
          // Add more PopupMenuItems as needed
        ];
      },
    );
  }
}
