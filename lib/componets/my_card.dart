import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:saif/componets/text_widget.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
   MyCard({super.key,required this.title,this.Qty,this.color,this.ontap});
String? title; 
String? Qty;
Color? color;
      Callback? ontap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: MyTextWidget(
                      text: '$title',
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: color,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: MyTextWidget(
                    text: '$Qty',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}