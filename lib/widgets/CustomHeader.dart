import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SliverAppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Container(
              height: 5,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        pinned: true,
        stretch: true,
        elevation: 5,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        backgroundColor: Theme.of(context).colorScheme.primary,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.all(0),
          stretchModes: const [StretchMode.zoomBackground],
          title: Container(
            padding: const EdgeInsets.only(left: 40, top: 15),
            height: 56,
            width: screenWidth,
            // color: Colors.white,
            child: const Text(
              'À propos de l\'application',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          background: Image.asset(
            'assets/images/adult.jpg',
            fit: BoxFit.cover,
          ),
        ));
  }
}
