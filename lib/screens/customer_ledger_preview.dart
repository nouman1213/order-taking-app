import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../componets/my_card.dart';
import '../componets/text_widget.dart';

class CustomeLedgerPreview extends StatelessWidget {
  const CustomeLedgerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Ledger'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PreviewListCard(context, 'A Trader', 'Debit', 'Credit',
                Theme.of(context).colorScheme.tertiary),
            SizedBox(height: 10),
            PreviewListCard(context, 'Openning Balance', '1000', '0',
                Theme.of(context).colorScheme.secondary),
            SizedBox(height: 10),
            MyTextWidget(text: '10-01-2023'),
            PreviewListCard(context, 'Sales Invoice', '10,500', '0',
                Theme.of(context).colorScheme.secondary),
            SizedBox(height: 10),
            MyTextWidget(text: '15-01-2023'),
            PreviewListCard(context, 'Receipt', '0', '5000',
                Theme.of(context).colorScheme.secondary),
            SizedBox(height: 10),
            MyTextWidget(text: '18-01-2023'),
            PreviewListCard(context, 'Adjustment', '0', '5,500',
                Theme.of(context).colorScheme.secondary),
            Spacer(),
            MyCard(
              title: 'Adjustment',
              color: Theme.of(context).colorScheme.primary,
              Qty: '500',
            )
          ],
        ),
      ),
    );
  }

  SizedBox PreviewListCard(
      context, String? title, String? dabit, String? credit, Color color,
      {Callback? ontap}) {
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
                    child: FittedBox(
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
                    text: '$dabit',
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
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
                    text: '$credit',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
