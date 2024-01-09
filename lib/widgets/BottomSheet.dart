import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 700,
            child: Text("Bottom sheet"),
          )
        ],
      ),
    );
  }
}
