import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:saif/services/service.dart';

import '../componets/my_card.dart';
import '../componets/text_widget.dart';
import '../model/customer_ledger_model.dart';

// ignore: must_be_immutable
class CustomeLedgerPreview extends StatelessWidget {
  CustomeLedgerPreview({super.key, this.fromDate, this.ToDate, this.psctd});
  final fromDate;
  final ToDate;
  final psctd;
  double totalAmount = 0;
  var openingBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Ledger'),
        elevation: 0,
      ),
      body: FutureBuilder<List<CustomerLegderModel>>(
        future: ApiService.getCustomerLedger(
            "Ledger/GetLedger?pstcd=$psctd&stdt=$fromDate&endt=$ToDate"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('An error occurred: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final ledger = snapshot.data;
            print(ledger);
            //calculate total amount
            for (int i = 0; i < ledger!.length; i++) {
              var oPBAL = ledger[i].oPBAL ?? 0;
              var bALDIFF = ledger[i].bALDIFF ?? 0;
              totalAmount += oPBAL + bALDIFF;
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: MyTextWidget(text: 'Customer Ledger Activity')),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From Date:   $fromDate',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'To Date:   $ToDate',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Openning Balance:   ${ledger[0].oPBAL}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 10),
                  HeadingCard(context, "Name", "Dabit", "Cedit", 'Amount',
                      Theme.of(context).colorScheme.primary),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      child: ListView.builder(
                        // shrinkWrap: true,

                        itemCount: ledger.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                              // vertical: BorderSide(),
                              horizontal:
                                  BorderSide(width: 1, color: Colors.grey),
                            )),
                            child: PreviewListCard(
                                context,
                                // "${ledger[index].sRNO}",
                                "${ledger[index].nAME}",
                                "${ledger[index].dEBIT ?? '00'}",
                                "${ledger[index].cREDIT ?? '00'}",
                                "${(ledger[index].oPBAL ?? 0) + (ledger[index].bALDIFF ?? 0)}"),
                          );
                        },
                      ),
                    ),
                  ),
                  // Spacer(),
                  MyCard(
                    title: 'Total Amount',
                    color: Theme.of(context).colorScheme.primary,
                    Qty: '$totalAmount',
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  SizedBox PreviewListCard(
      context, String? name, String? dabit, String? credit, String? balance,
      {Callback? ontap}) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          // Expanded(
          //   // flex: 1,
          //   child: Card(
          //     // elevation: 5,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Align(
          //           alignment: Alignment.bottomLeft,
          //           child: SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: Text(
          //               '$srno',
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 // fontWeight: FontWeight.w200,
          //                 // color: Theme.of(context).colorScheme.on,
          //               ),
          //             ),
          //           )),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$name',
                          style: TextStyle(
                            fontSize: 12,
                            // fontWeight: FontWeight.w600,
                            // color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$dabit',
                          style: TextStyle(
                            fontSize: 12,

                            // fontWeight: FontWeight.w600,
                            // color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$credit',
                          style: TextStyle(
                            fontSize: 12,

                            // fontWeight: FontWeight.w600,
                            // color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$balance',
                          style: TextStyle(
                            fontSize: 12,

                            // fontWeight: FontWeight.w600,
                            // color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox HeadingCard(context, String? name, String? dabit, String? credit,
      String? balance, Color color,
      {Callback? ontap}) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          // Expanded(
          //   // flex: 1,
          //   child: InkWell(
          //     onTap: ontap,
          //     child: Card(
          //       color: color,
          //       elevation: 5,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Align(
          //             alignment: Alignment.bottomLeft,
          //             child: SingleChildScrollView(
          //               scrollDirection: Axis.horizontal,
          //               child: Text(
          //                 '$srno',
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   color: Theme.of(context).colorScheme.onPrimary,
          //                 ),
          //               ),
          //             )),
          //       ),
          //     ),
          //   ),
          // ),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$dabit',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$credit',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$balance',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
