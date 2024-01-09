// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/pages/AllBookScreen.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';

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
  late String soramandry = '';
  bool isLightMode = true;
  double zoomLevel = 1.0;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchAndininyText();
  }

  void fetchAndininyText() async {
    int tokoAsInt = int.tryParse(widget.toko) ?? 0;
    currentPage = tokoAsInt;
    int tokoId = await DBHelper.getTokoValue(widget.nomLivre, tokoAsInt);
    print("TOKO ID VENANT D'ici: $tokoId");
    List<String> andininyResult = await DBHelper.getAndininyTexts(tokoId);

    // Stocker le texte entre crochets dans la variable soramandry
    soramandry = extractTextBetweenBrackets(andininyResult.first);

    // Filtrer le texte pour l'affichage
    setState(() {
      andininyTexts = andininyResult
          .map((text) => _filterTextBetweenBrackets(text))
          .toList();
    });
    _scrollController = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollToPosition(); // Appelé après le premier rendu de la frame
    });
  }

  void _scrollToSpecificElement() {
    int indexToScroll = int.parse(widget.andininy);

    double positionToScroll = indexToScroll * 62;

    print("scrolling");
    _scrollController.jumpTo(positionToScroll);
  }

  void scrollToPosition() {
    int indexToScroll = int.parse(widget.andininy);

    double positionToScroll = indexToScroll * 65;

    // Assurez-vous que le contrôleur de défilement est attaché à votre CustomScrollView
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(positionToScroll);
    }
  }

  String _filterTextBetweenBrackets(String text) {
    // Utiliser une expression régulière pour filtrer le texte entre crochets
    return text.replaceAll(RegExp(r'\[.*?\]'), '');
  }

  String extractTextBetweenBrackets(String text) {
    RegExp regex = RegExp(r'\[(.*?)\]');
    Match? match = regex.firstMatch(text);
    String extractedText = match?.group(1) ?? '';
    return extractedText.replaceAll(RegExp(r'^\[|\]$'), '');
  }

  void incrementToko() {
    setState(() {
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
      body: Swiper(
          itemCount: 50,
          // layout: SwiperLayout.CUSTOM,
          // customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          //   ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
          //   ..addTranslate([
          //     const Offset(-370.0, -40.0),
          //     const Offset(0.0, 0.0),
          //     const Offset(370.0, -40.0)
          //   ]),
    
          onIndexChanged: (int index) {
            // Mettez à jour widget.toko en fonction de l'index
            setState(() {
              currentPage = (index + 1);
            });
            fetchAndininyText();
          },
          itemBuilder: (BuildContext context, index) {
            return DraggableBottomSheet(
              // collapsed: true,
              backgroundWidget: Scaffold(
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // SliverAppBar(
                    //   pinned: true,
                    //   backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
                    //   foregroundColor: Colors.white,
                    //   titleSpacing: -5,
                    //   title: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "${widget.nomLivre} ${widget.toko} : $currentPage ",
                    //         style: const TextStyle(fontSize: 18),
                    //       ),
                    //       Row(
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               // Navigate to the home screen
                    //               Navigator.of(context)
                    //                   .popUntil((route) => route.isFirst);
                    //             },
                    //             child: const Padding(
                    //               padding: EdgeInsets.only(right: 20),
                    //               child: Icon(Icons.home),
                    //             ),
                    //           ),
                    //           _buildPopupMenuButton(),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      title: Container(
                          child: RichText(
                        text: TextSpan(
                          text: soramandry,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            // child: GestureZoomBox(
                            //   maxScale: 5.0,
                            //   doubleTapScale: 2.0,
                            child: InkWell(
                                overlayColor:
                                    const MaterialStatePropertyAll(Colors.red),
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
              ),
              previewWidget: _previewWidget(),
              expandedWidget: _expandedWidget(),
              onDragging: (double) {},
            );
          }),
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

  Widget _previewWidget() {
    return Container(
      // height: 20,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(81, 30, 88, 233),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 234, 234, 235),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: isLightMode,
                onChanged: (value) {
                  setState(() {
                    isLightMode = value;
                    // Appliquez le thème ici en fonction de la valeur de l'interrupteur
                  });
                },
                activeColor: Colors.blue, // Couleur quand le thème est activé
                inactiveThumbColor:
                    Colors.grey, // Couleur quand le thème est désactivé
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Apparence',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Slider(
            value: zoomLevel,
            onChanged: (value) {
              setState(() {
                zoomLevel = value;
                // Mettez à jour le zoom du texte ici
              });
            },
            min: 1.0,
            max: 3.0,
            divisions: 20,
            label: '$zoomLevel',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.home, color: Colors.pink, size: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}
