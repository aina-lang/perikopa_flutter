import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:perikopa_flutter/config/AppStyle.dart';
import 'package:perikopa_flutter/config/ThemeProvider.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/pages/AllBookScreen.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late Color themBg = Colors.white;
  bool isLightMode = false;
  double zoomLevel = 1.0;
  late String titleLivre = "";
  late ScrollController _scrollController;
  late int currentIndex;
  late int itemCount = 0;
  late String pressedAndininy = "";
  late String Code = "";
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    int tokoAsInt = int.tryParse(widget.toko) ?? 0;
    currentPage = tokoAsInt;
    currentIndex = 0;
    Code = widget.nomLivre;
    fetchAndininyText(widget.nomLivre);
  }

  void fetchItem() async {
    itemCount = await DBHelper.getCountForBook(widget.nomLivre);
  }

  bool isDarkMode = false;

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  void fetchAndininyText(String nom) async {
    itemCount = await DBHelper.getCountForBook(nom);
    int tokoId = await DBHelper.getTokoValue(nom, currentPage);
    titleLivre = await DBHelper.getNomLivre(nom);
    if (currentPage < itemCount+1 ) {
      print(
          "1 BOKY ${titleLivre} TOTAL TOKO :${itemCount} CURRENT INDEX :${currentIndex}");
      List<String> andininyResult = await DBHelper.getAndininyTexts(tokoId);

      setState(() {
        soramandry = extractTextBetweenBrackets(andininyResult.first);
        andininyTexts = andininyResult
            .map((text) => _filterTextBetweenBrackets(text))
            .toList();
      });
    } else {
      // currentIndex = 0;
      currentPage = 1;
      String? nomLivre = await DBHelper.getNextBook(nom);
      int tokoId = await DBHelper.getTokoValue(nomLivre!, currentPage);
      List<String> andininyResult = await DBHelper.getAndininyTexts(tokoId);
      soramandry = extractTextBetweenBrackets(andininyResult.first);
      titleLivre = await DBHelper.getNomLivre(nomLivre);
      itemCount = await DBHelper.getCountForBook(nomLivre);
      print(
          "2 BOKY ${titleLivre} TOTAL TOKO :${itemCount} CURRENT INDEX :${currentIndex}");
      setState(() {
        andininyTexts = andininyResult
            .map((text) => _filterTextBetweenBrackets(text))
            .toList();
        Code = nomLivre;
      });
    }

    _scrollController = ScrollController();

    // print(int.parse(widget.andininy));
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollToPosition(int.parse(widget.andininy));
    });
  }

  void scrollToPosition(int i) {
    int indexToScroll = i;

    double positionToScroll = indexToScroll * 65;

    // print("scrolling");
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        titleSpacing: -5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${titleLivre} $currentPage ",
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
          itemCount: 66,
          // index: 0,
          onIndexChanged: (index) {
            print(
                "INDEX ${index} CURRENTPAGE ${currentPage} CURRENT INDEX ${currentIndex}");
            setState(() {
              if (index == currentIndex + 1 ) {
                currentPage = (currentPage + 1);
              } else if (index != currentIndex + 1 ) {
                currentPage = (currentPage - 1);
              }
              currentIndex = index;
            });
            fetchAndininyText(Code);
            print(
                "INDEX ${index} CURRENTPAGE ${currentPage} CURRENT INDEX ${currentIndex}");
            // WidgetsBinding.instance?.addPostFrameCallback((_) {
            //   scrollToPosition(0);
            // });
          },
          itemBuilder: (BuildContext context, index) {
            return DraggableBottomSheet(
              // collapsed: true,
              // barrierColor: th,
              backgroundWidget: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: soramandry.isNotEmpty ? 90 : 0,
                      flexibleSpace: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RichText(
                            text: TextSpan(
                              text: soramandry,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontStyle: FontStyle.italic,
                                fontSize: zoomLevel + 16,
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
                            child: FocusedMenuHolder(
                                onPressed: () {
                                  setState(() {
                                    pressedAndininy = (index + 1).toString();
                                  });
                                  print(pressedAndininy);
                                },
                                blurBackgroundColor:
                                    const Color.fromARGB(75, 78, 78, 78),
                                animateMenuItems: true,
                                menuItems: [
                                  FocusedMenuItem(
                                      title: Text(
                                        "${titleLivre} ${currentPage} : ${index + 1}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      // trailingIcon: const Icon(Icons.copy),

                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  FocusedMenuItem(
                                    title: const Text("Copier"),
                                    trailingIcon: const Icon(Icons.copy),
                                    onPressed: () {
                                      final data = ClipboardData(
                                          text:
                                              andininyTexts[index].toString());
                                      Clipboard.setData(data);
                                      print(Clipboard.getData("text/plain"));

                                      showSnack(context);
                                    },
                                  ),
                                  FocusedMenuItem(
                                      title: const Text("Partager"),
                                      trailingIcon: const Icon(Icons.share),
                                      onPressed: () {
                                        print("yes");
                                      }),
                                  FocusedMenuItem(
                                      title: const Text("Enregistrer"),
                                      trailingIcon: const Icon(Icons.save),
                                      onPressed: () {
                                        print("yes");
                                      }),
                                  FocusedMenuItem(
                                    title: const Text(
                                      "Marquer",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailingIcon: const Icon(
                                      Icons.mark_as_unread,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      print("yes");
                                    },
                                  ),
                                ],
                                openWithTap: false,
                                child: InkWell(
                                  onTap: () {},
                                  // onLongPress: () {
                                  //   setState(() {
                                  //     pressedAndininy = (index + 1).toString();
                                  //   });
                                  //   print(pressedAndininy);
                                  // },
                                  child: RichText(
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 46, 46, 46)),
                                      children: [
                                        TextSpan(
                                          text: "${index + 1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: zoomLevel + 16.0,
                                              color: Colors.blue),
                                        ),
                                        const TextSpan(text: "   "),
                                        TextSpan(
                                          text: "${andininyTexts[index]}",
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: zoomLevel + 14.0),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                        childCount: andininyTexts.length,
                      ),
                    ),
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
            child: Text('Verset enregistré'),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text('Verset marqué'),
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
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                  setState(() {
                    isLightMode = value;
                    themBg = Colors.black;
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
            activeColor: Colors.blue,
            value: zoomLevel,
            onChanged: (value) {
              setState(() {
                zoomLevel = value;
                // Mettez à jour le zoom du texte ici
              });
            },
            min: 1.0,
            max: 5.0,
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

  void showSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text("Copied"),
      duration: Duration(milliseconds: 3000),
    ));
  }
}
