// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var jsonData;

  @override
  void initState() {
    InitDataFromJson();
  }

  void InitDataFromJson() async {
    final String response =
        await rootBundle.loadString('assets/listPerikopa.json');
    final data = await json.decode(response);
    setState(() {
      jsonData = data;
    });
  }

  List<Map<String, dynamic>>? getVersetForMonth(String monthName) {
    // print(jsonData);
    if (jsonData != null) {
      var mois = jsonData['mois'];
      print(mois);
      for (var moisData in mois) {
        if (moisData['nom'] == monthName) {
          var perikopa = moisData['perikopa'];

          if (perikopa != null && perikopa.isNotEmpty) {
            return perikopa[0]['verset'];
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    InitDataFromJson();
    List<Map<String, dynamic>>? versets = getVersetForMonth("Janvier");
    // print(versets);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (versets != null)
          for (int i = 0; i < versets.length; i++)
            _buildTextButton(
              versets[i]['shortName'],
              versets[i]['andininyStart'],
              versets[i]['andininyEnd'],
              i + 1,
            ),
      ],
    );
  }

  Widget _buildTextButton(
    String versetName,
    int andininyStart,
    int andininyEnd,
    int buttonNumber,
  ) {
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Verset $versetName'),
                  content: Text(
                    "$versetName ${andininyStart}-${andininyEnd}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Fermer'),
                    ),
                  ],
                );
              },
            );
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              (buttonNumber == 1 && (isButton1Hovered || isButton1Focused)) ||
                      (buttonNumber == 2 &&
                          (isButton2Hovered || isButton2Focused)) ||
                      (buttonNumber == 3 &&
                          (isButton3Hovered || isButton3Focused))
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
                return null;
              },
            ),
          ),
          child: Text(
            versetName,
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
