import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  MyCard(
      {super.key,
      required this.title,
      this.debit,
      this.credit,
      this.color,
      this.amount,
      this.ontap});
  String? title;
  String? debit;
  String? credit;
  String? amount;
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
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('$title',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          )),
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
              child: SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('$debit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          )),
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
              child: SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('$credit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(width: 20)
          Expanded(
            child: Card(
              color: color,
              elevation: 5,
              child: SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text('$amount',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
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
