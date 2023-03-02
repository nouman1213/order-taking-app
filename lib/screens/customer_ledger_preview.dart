import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:saif/services/service.dart';
import 'package:saif/theme/color_scheme.dart';

import '../componets/my_card.dart';
import '../model/customer_ledger_model.dart';

// ignore: must_be_immutable
class CustomeLedgerPreview extends StatefulWidget {
  CustomeLedgerPreview({super.key, this.fromDate, this.ToDate, this.psctd});
  final fromDate;
  final ToDate;
  final psctd;

  @override
  State<CustomeLedgerPreview> createState() => _CustomeLedgerPreviewState();
}

class _CustomeLedgerPreviewState extends State<CustomeLedgerPreview> {
  final dateFormat = DateFormat("dd-MMM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Ledger'),
        elevation: 0,
      ),
      body: FutureBuilder<List<CustomerLegderModel>>(
        future: ApiService.getCustomerLedger(
            "Ledger/GetLedger?pstcd=${widget.psctd}&stdt=${widget.fromDate}&endt=${widget.ToDate}"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Something went wrong please try lator'),
            );
          }
          if (snapshot.hasData) {
            String? formatBalance;
            final ledger = snapshot.data;
            /////////////////////////
            var tempBal = 0.0;
            var tempDebit = 0.0;
            var tempCredit = 0.0;
            for (var i = 0; i < ledger!.length; i++) {
              tempDebit = tempDebit + ((ledger[i].dEBIT ?? 0));
              tempCredit = tempCredit + ((ledger[i].cREDIT ?? 0));
            }
            var tempopbala = (ledger[0].oPBAL ?? 0);
            tempBal = tempopbala;
            tempBal = tempBal + (tempDebit - tempCredit);
            String formatTempBal =
                NumberFormat("#,##0.##", "en_US").format(tempBal);

            // print(ledger);

            double sumDebit = 0.0;
            double sumCredit = 0.0;
            for (int i = 0; i < ledger.length; i++) {
              sumDebit += (ledger[i].dEBIT ?? 0);
              sumCredit += (ledger[i].cREDIT ?? 0);
            }
            String formatDebit =
                NumberFormat("#,##0.##", "en_US").format(sumDebit);
            String formatCredit =
                NumberFormat("#,##0.##", "en_US").format(sumCredit);
            String formatOpeningBal =
                NumberFormat("#,##0.##", "en_US").format(ledger[0].oPBAL ?? 0);

            ///
            double openingBalance = ledger[0].oPBAL ?? 0;

            double balancevalue = openingBalance;

            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  Center(
                    child: Text(
                      '${ledger[0].nAME}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "From Date:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: fontGrey)),
                        TextSpan(
                            text: "${widget.fromDate}",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.w400,
                            )),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "To Date:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: fontGrey)),
                        TextSpan(
                            text: "${widget.ToDate}",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.w400,
                            )),
                      ])),
                    ],
                  ),

                  SizedBox(height: 10),
                  HeadingCard(context, "Description", "Dabit", "Cedit",
                      'Balance', Theme.of(context).colorScheme.primary),
                  SizedBox(height: 10),
                  // Divider(thickness: 1, color: Colors.grey),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Openning Balance: ${formatOpeningBal.toString()}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),

                  SizedBox(height: 10),

                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.amber,
                            child: ListView.builder(
                              itemCount: ledger.length,
                              itemBuilder: (BuildContext context, int index) {
                                //calculate debit and credit from openningBalance
                                String debitvalue =
                                    "${ledger[index].dEBIT ?? '00'}";
                                String creditvalue =
                                    "${ledger[index].cREDIT ?? '00'}";

                                int debit = int.parse(debitvalue.split(".")[0]);
                                int credit =
                                    int.parse(creditvalue.split(".")[0]);
                                balancevalue += debit - credit;
                                formatBalance =
                                    NumberFormat("#,##0.##", "en_US")
                                        .format(balancevalue);
                                var formatdebit =
                                    NumberFormat("#,##0.##", "en_US")
                                        .format(debit);
                                var formatcred =
                                    NumberFormat("#,##0.##", "en_US")
                                        .format(credit);
                                // var formatQTy = int.parse(
                                //     ledger[index].qTY ?? '--'.split(".")[0]);
                                // var formatRate = int.parse(
                                //     ledger[index].rATE ?? '--'.split(".")[0]);

                                //date formate

                                String? dateRange = ledger[index].vDT;
                                String? formattedFromDate;

                                if (dateRange != null) {
                                  formattedFromDate = dateRange.split(" ")[0];
                                }

                                if (formattedFromDate != null) {
                                  DateTime fromDateTime =
                                      DateTime.parse(formattedFromDate);
                                  formattedFromDate =
                                      "${fromDateTime.day}-${fromDateTime.month}-${fromDateTime.year}";
                                }
                                // String? dateRange = ledger[index].vDT;
                                // String? fromDate = dateRange!.split(" ")[0];
                                // DateTime fromDateTime =
                                //     DateTime.parse(fromDate);

                                // String formattedFromDate =
                                //     "${fromDateTime.day}-${fromDateTime.month}-${fromDateTime.year}";
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.symmetric(
                                      // vertical: BorderSide(),
                                      horizontal: BorderSide(
                                          width: 1, color: Colors.grey),
                                    )),
                                    child: PreviewListCard(
                                      context,
                                      "${formattedFromDate?.toString() ?? "Date--"}",
                                      "${ledger.elementAt(index).vTYP?.toString() ?? 'Type --'}",
                                      "${ledger.elementAt(index).sRNO?.toString() ?? 'SRNO --'}",
                                      "${formatdebit}",
                                      "${formatcred}",
                                      "${formatBalance?.toString() ?? ''}",
                                      "${ledger.elementAt(index).bRAND?.toString() ?? "--"}",
                                      "${ledger.elementAt(index).qTY?.toDouble()?.truncate().toString() ?? "--"}",
                                      "${ledger.elementAt(index).rATE?.toDouble()?.truncate().toString() ?? "--"}",
                                    )

                                    // child: PreviewListCard(
                                    //   context,
                                    //   "${formattedFromDate}",
                                    //   "${ledger[index].vTYP?.toString() ?? ''}",
                                    //   "${ledger[index].sRNO?.toString() ?? ''}",
                                    //   "${formatdebit}",
                                    //   "${formatcred}",
                                    //   "${formatBalance?.toString() ?? ''}",
                                    //   "${ledger[index].bRAND?.toString() ?? "--"}",
                                    //   "${ledger[index].qTY?.toString() ?? "--"}",
                                    //   "${ledger[index].rATE?.toString() ?? "--"}",
                                    // )

                                    );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  MyCard(
                    title: 'Closing Balance',
                    color: Theme.of(context).colorScheme.primary,
                    debit: '$formatDebit',
                    credit: '$formatCredit',
                    amount: "$formatTempBal",
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
      context,
      String? date,
      String? type,
      String? name,
      String? dabit,
      String? credit,
      String? balance,
      String? brand,
      var qty,
      var rate,
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
                // elevation: 5,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '$date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    // fontWeight: FontWeight.w600,
                                    // color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.070),
                            Align(
                              // alignment: Alignment.topRight,
                              child: Text(
                                '$type',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  // color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBe tween,
                          children: [
                            Expanded(
                                child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'B:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '$brand',
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Q:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$qty',
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'R:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '$rate',
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w600,
                                      // color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: SingleChildScrollView(
                              child: Text(
                                '$name',
                                style: TextStyle(
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600,
                                  // color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
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
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
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
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                // elevation: 5,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerRight,
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
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '$name',
                            style: TextStyle(
                              // fontSize: 1,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )),
                  ),
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
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                        alignment: Alignment.center,
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
          ),
          Expanded(
            // flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                        alignment: Alignment.center,
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
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: ontap,
              child: Card(
                color: color,
                elevation: 5,
                child: SizedBox(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                        alignment: Alignment.center,
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
          ),
        ],
      ),
    );
  }
}
