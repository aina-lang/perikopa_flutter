// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const FilledButton({required this.onPressed, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromRGBO(63, 81, 181, 1), // Couleur de fond du bouton
        elevation: 0, // Supprimer l'élévation pour un aspect plat
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: child,
    );
  }
}

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSection();
}

class _SearchSection extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        height: 45,
        width: screenWidth - 30,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: true,
                autofocus: false,
                style: TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                    hintText: 'Rechercher des versets',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            SizedBox(width: 8.0),
            MaterialButton(
              // padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
              // color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
             
            ),
          ],
        ),
      ),
    );
  }
}
