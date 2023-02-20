import 'package:flutter/material.dart';
import 'package:saif/componets/text_widget.dart';

class MyHomeCard extends StatelessWidget {
  const MyHomeCard({super.key, required this.text, required this.imagePath});
  final text;
  final imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(),
              borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width - 20,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 100,
                ),
                MyTextWidget(
                  text: text,
                  size: 18.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
