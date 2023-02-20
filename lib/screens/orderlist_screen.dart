import 'package:flutter/material.dart';

import '../componets/text_widget.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Orders"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // SizedBox(height: 30),
              orderListCard(
                context,
                "Customer Name",
                "Qty",
                Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: List.generate(20, (index) {
                  return orderListCard(context, "Ali", "100",
                      Theme.of(context).colorScheme.secondary);
                }),
              )))
            ],
          ),
        ),
      ),
    );
  }

  SizedBox orderListCard(
      BuildContext context, String? title, String? Qty, Color color) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Card(
              color: color,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyTextWidget(
                      text: '$title',
                      color: Theme.of(context).colorScheme.onTertiary,
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
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: MyTextWidget(
                    text: '$Qty',
                    color: Theme.of(context).colorScheme.onTertiary,
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
