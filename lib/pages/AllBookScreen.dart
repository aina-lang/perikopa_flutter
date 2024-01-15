import 'package:flutter/material.dart';
import 'package:perikopa_flutter/models/helperSqlte.dart';
import 'package:perikopa_flutter/models/Book.dart';
import 'package:perikopa_flutter/pages/TokoScreen.dart';

class AllBookScreen extends StatefulWidget {
  const AllBookScreen({super.key});

  @override
  State<AllBookScreen> createState() => _AllBookScreenState();
}

class _AllBookScreenState extends State<AllBookScreen> {
  List<Book>? books;
  List<bool> boutonClique = List.generate(66, (index) => false);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Book>? bookList = await DBHelper.getAllBook();

    print("LIST BOOK ${bookList!.length}");
    setState(() {
      books = bookList;
    });
  }

//  late SwiperController _swiperController;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            // surfaceTintColor: Colors.red,

            foregroundColor: Colors.white,
            backgroundColor:  Theme.of(context).colorScheme.primary,
            // title:
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                stretchModes: const [StretchMode.zoomBackground],
                collapseMode: CollapseMode.parallax,
                background: Image.asset(
                  'assets/images/jesus.jpg',
                  fit: BoxFit.cover,
                  width: screenWidth,
                ),
                title: Container(
                  height: 50,
                  width: screenWidth,
                  padding: const EdgeInsets.only(left: 50, top: 12),
                  // color: Colors.amber,
                  child: const Text(
                    "Ny boky Rehetra",
                    style: TextStyle(fontSize: 16),
                  ),
                )),
          ),
          // ignore: prefer_const_constructors
          SliverPadding(padding: EdgeInsets.all(10)),
          SliverAppBar(
            // actions: null,
            pinned: false,
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Color.fromARGB(255, 78, 77, 77),
            automaticallyImplyLeading: false,
            // forceMaterialTransparency: Color.fromARGB(255, 220, 229, 250),
            title: SizedBox(
              height: 40,
              // color: Colors.amber,
              child: Text(
                "TESTAMENTA TALOHA",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, index) {
                Book book = books![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //  boxShadow: [BoxShadow(color: Color.fromARGB(155, 95, 94, 94),blurRadius: 1,offset: Offset(1,1),spreadRadius: 0.5)]
                          
                      color: boutonClique[index]
                          ?  Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TokoScreen(
                                    nomLivre: book.code,
                                  )),
                        );
                        setState(() {
                          boutonClique[index] = !boutonClique[index];
                          for (int i = 0; i < boutonClique.length; i++) {
                            if (i != index) {
                              boutonClique[i] = false;
                            }
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: boutonClique[index]
                            ? MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primary)
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor: boutonClique[index]
                            ? MaterialStateProperty.all(Colors.white)
                            : MaterialStateProperty.all(Color.fromARGB(255, 146, 147, 148)),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(book.name ?? ''), // Handle nullable 'shortName'
                          Icon(Icons.navigate_next_outlined)
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: books != null ? books!.length : 0,
            ),
          ),
        ],
      ),
    );
  }
}
