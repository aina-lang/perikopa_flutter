// ignore_for_file: prefer_const_constructors, avoid_print, file_names, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:perikopa_flutter/pages/AllBookScreen.dart';
import 'package:perikopa_flutter/pages/AproposScreen.dart';
import 'package:perikopa_flutter/pages/HomeScreen.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  void printToko() async {
    // List toko=DBHelper.getTokoValue(widget, numero)
  }

 

  @override
  Widget build(BuildContext context) {
    printToko();

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AllBookScreen()));
        },
        backgroundColor:  Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.menu_book_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Theme.of(context).colorScheme.background,
        shape: CircularNotchedRectangle(),
        shadowColor: Colors.grey,
        notchMargin: 10,
        child: SizedBox(
          // color: Colors.amber,
          height: 40,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = HomeScreen();
                          _currentIndex = 0;
                        });
                      },
                      textColor: _currentIndex == 0
                          ? Color.fromRGBO(63, 81, 181, 1)
                          : Colors.grey,
                      child:
                          Column(children: [Icon(Icons.home), Text("Accueil")]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = AproposScreen();
                          _currentIndex = 1;
                        });
                      },
                      textColor: _currentIndex == 1
                          ?  Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      child:
                          Column(children: [Icon(Icons.info), Text("Apropos")]),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Code pour la page des notes
    return Container();
  }
}
