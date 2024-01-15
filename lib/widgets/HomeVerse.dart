// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

class HomeVerse extends StatefulWidget {
  const HomeVerse({Key? key}) : super(key: key);

  @override
  State<HomeVerse> createState() => _HomeVerseState();
}

class _HomeVerseState extends State<HomeVerse> {
  bool isButton1Hovered = false;
  bool isButton1Focused = false;

  bool isButton2Hovered = false;
  bool isButton2Focused = false;

  bool isButton3Hovered = false;
  bool isButton3Focused = false;

  @override
  Widget build(BuildContext context) {
    return Row(
    
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextButton("Matio 3:2", 1),
        _buildTextButton("Matio 3:2", 2),
        _buildTextButton("Matio 3:2", 3),
        _buildTextButton("Matio 3:2", 4),
      ],
    );
  }

  Widget _buildTextButton(String text, int buttonNumber) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          if (buttonNumber == 1) {
            isButton1Hovered = true;
          } else if (buttonNumber == 2) {
            isButton2Hovered = true;
          } else if (buttonNumber == 3) {
            isButton3Hovered = true;
          }
        });
      },
      onExit: (event) {
        setState(() {
          if (buttonNumber == 1) {
            isButton1Hovered = false;
          } else if (buttonNumber == 2) {
            isButton2Hovered = false;
          } else if (buttonNumber == 3) {
            isButton3Hovered = false;
          }
        });
      },
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            if (buttonNumber == 1) {
              isButton1Focused = hasFocus;
            } else if (buttonNumber == 2) {
              isButton2Focused = hasFocus;
            } else if (buttonNumber == 3) {
              isButton3Focused = hasFocus;
            }
          });
        },
        child: TextButton(
          onPressed: () {
            print("Bouton $buttonNumber cliqué !");
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              (isButton1Hovered || isButton1Focused)
                  ? Color.fromRGBO(63, 81, 181, 1)
                  : Color.fromARGB(221, 45, 43, 43),
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromRGBO(63, 81, 181, 1).withOpacity(0.04);
                }
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed)) {
                  return Color.fromRGBO(63, 81, 181, 1).withOpacity(0.12);
                }
                return null; // Defer to the widget's default.
              },
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              color: Color.fromARGB(221, 80, 75, 78),
            ),
          ),
        ),
      ),
    );
  }
}
