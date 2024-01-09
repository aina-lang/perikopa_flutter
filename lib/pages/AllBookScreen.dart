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
      backgroundColor: const Color(0xFFF5F6F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            // surfaceTintColor: Colors.red,

            foregroundColor: Colors.white,
            backgroundColor: Color.fromRGBO(63, 81, 181, 1),
            // title:
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                stretchModes: const [StretchMode.zoomBackground],
                collapseMode: CollapseMode.parallax,
                background: Image.asset(
                  'assets/images/girl.jpg',
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
          const SliverAppBar(
            // actions: null,
            pinned:false,
            backgroundColor: Color(0xFFF5F6F9),
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
                return FutureBuilder<List<Book>?>(
                  future: DBHelper.getAllBook(),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   // Return a loading indicator or placeholder widget
                    //   return const CircularProgressIndicator();
                    // } else if (snapshot.hasError) {
                    //   // Handle the error
                    //   return Text('Error: ${snapshot.error}');
                    // } else
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Handle the case where there are no books
                      return Text('');
                    } else {
                      // Filter books where id == 1
                      // List<Book> filteredBooks = snapshot.data!
                      //     .where((book) => book.id == 1)
                      //     .toList();

                      // Ensure the index is within the valid range
                      if (index >= 0 && index < books!.length) {
                        // Build the SliverChildBuilderDelegate using the filtered book data
                        Book book = books![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: boutonClique[index]
                                  ? Color.fromRGBO(63, 81, 181, 1)
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
                                  for (int i = 0;
                                      i < boutonClique.length;
                                      i++) {
                                    if (i != index) {
                                      boutonClique[i] = false;
                                    }
                                  }
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: boutonClique[index]
                                    ? MaterialStateProperty.all(
                                        Color.fromRGBO(63, 81, 181, 1))
                                    : MaterialStateProperty.all(Colors.white),
                                foregroundColor: boutonClique[index]
                                    ? MaterialStateProperty.all(Colors.white)
                                    : MaterialStateProperty.all(Colors.grey),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 20, right: 5),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(book.name ??
                                      ''), // Handle nullable 'shortName'
                                  Icon(Icons.navigate_next_outlined)
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Handle the case where the index is out of range
                        return SizedBox.shrink();
                      }
                    }
                  },
                );
              },
              childCount: books!.length,
            ),
          ),

          // const SliverAppBar(
          //   // actions: null,
          //   pinned: true,
          //   backgroundColor: Color(0xFFF5F6F9),
          //   foregroundColor: Color.fromARGB(255, 78, 77, 77),
          //   automaticallyImplyLeading: false,
          //   // forceMaterialTransparency: Color.fromARGB(255, 220, 229, 250),
          //   title: SizedBox(
          //     height: 40,
          //     // color: Colors.amber,
          //     child: Text(
          //       "TESTAMENTA VAOVAO",
          //       style: TextStyle(fontSize: 15),
          //     ),
          //   ),
          // ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, index) {
          //       return FutureBuilder<List<Book>?>(
          //         future: DBHelper.getAllBook(),
          //         builder: (context, snapshot) {
          //           // if (snapshot.connectionState == ConnectionState.waiting) {
          //           //   // Return a loading indicator or placeholder widget
          //           //   return const CircularProgressIndicator();
          //           // } else if (snapshot.hasError) {
          //           //   // Handle the error
          //           //   return Text('Error: ${snapshot.error}');
          //           // } else
          //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //             // Handle the case where there are no books
          //             return Text('');
          //           } else {
          //             // Filter books where id == 1
          //             List<Book> filteredBooks =
          //                 snapshot.data!.where((book) => book.id == 2).toList();

          //             // Ensure the index is within the valid range
          //             if (index >= 0 && index < filteredBooks.length) {
          //               // Build the SliverChildBuilderDelegate using the filtered book data
          //               Book book = filteredBooks[index];
          //               return Padding(
          //                 padding: const EdgeInsets.symmetric(
          //                     horizontal: 15, vertical: 5),
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(15),
          //                     color: boutonClique[index]
          //                         ? Color.fromRGBO(63, 81, 181, 1)
          //                         : Colors.white,
          //                   ),
          //                   child: FilledButton(
          //                     onPressed: () {
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) => TokoScreen(
          //                                   nomLivre: book.code,
          //                                 )),
          //                       );
          //                       setState(() {
          //                         boutonClique[index] = !boutonClique[index];
          //                         for (int i = 0;
          //                             i < boutonClique.length;
          //                             i++) {
          //                           if (i != index) {
          //                             boutonClique[i] = false;
          //                           }
          //                         }
          //                       });
          //                     },
          //                     style: ButtonStyle(
          //                       backgroundColor: boutonClique[index]
          //                           ? MaterialStateProperty.all(
          //                               Color.fromRGBO(63, 81, 181, 1))
          //                           : MaterialStateProperty.all(Colors.white),
          //                       foregroundColor: boutonClique[index]
          //                           ? MaterialStateProperty.all(Colors.white)
          //                           : MaterialStateProperty.all(Colors.grey),
          //                       padding: MaterialStateProperty.all(
          //                         const EdgeInsets.only(
          //                             top: 15, bottom: 15, left: 20, right: 5),
          //                       ),
          //                     ),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(book.code ??
          //                             ''), // Handle nullable 'shortName'
          //                         Icon(Icons.navigate_next_outlined)
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             } else {
          //               // Handle the case where the index is out of range
          //               return SizedBox.shrink();
          //             }
          //           }
          //         },
          //       );
          //     },
          //     childCount: 42,
          //   ),
          // ),
        ],
      ),
    );
  }
}
