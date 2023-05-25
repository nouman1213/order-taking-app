// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:intl/intl.dart';
// import 'package:saif/services/service.dart';
// import 'package:saif/theme/color_scheme.dart';

// import '../componets/my_card.dart';
// import '../model/customer_ledger_model.dart';

// // ignore: must_be_immutable
// class CustomeLedgerPreview extends StatefulWidget {
//   CustomeLedgerPreview({super.key, this.fromDate, this.ToDate, this.psctd});
//   final fromDate;
//   final ToDate;
//   final psctd;

//   @override
//   State<CustomeLedgerPreview> createState() => _CustomeLedgerPreviewState();
// }

// class _CustomeLedgerPreviewState extends State<CustomeLedgerPreview> {
//   // final dateFormat = DateFormat("dd-MMM-yyyy");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Ledger'),
//         elevation: 0,
//       ),
//       body: FutureBuilder<List<CustomerLegderModel>>(
//         future: ApiService.getCustomerLedger(
//             "Ledger/GetLedger?pstcd=${widget.psctd}&stdt=${widget.fromDate}&endt=${widget.ToDate}"),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           }
//           if (snapshot.hasError) {
//             print(snapshot.error);
//             return Center(
//               child: Text('Something went wrong please try lator'),
//             );
//           }
//           if (snapshot.hasData) {
//             String? formatBalance;
//             final ledger = snapshot.data;

//             ////////////////////////
//             List<double> debitValues = [];
//             List<double> creditValues = [];
//             List<double> balanceValues = [];
//             double debitValue = 0.0;
//             double creditValue = 0.0;
//             for (var i = 0; i < ledger!.length; i++) {
//               double balance;

//               debitValue = debitValue + ((ledger[i].debit ?? 0));
//               creditValue = creditValue + ((ledger[i].credit ?? 0));
//               // double debit = double.parse(debitValue);
//               // double credit = double.parse(creditValue);

//               double opnBalance = ledger[i].opBal!.toDouble();
//               balance = opnBalance;

//               balance += (debitValue - creditValue);

//               debitValues.add(debitValue);
//               creditValues.add(creditValue);
//               balanceValues.add(balance);
//             }
//             /////////////////////////
//             var tempBal = 0.0;
//             var tempDebit = 0.0;
//             var tempCredit = 0.0;
//             for (var i = 0; i < ledger.length; i++) {
//               tempDebit = tempDebit + ((ledger[i].debit ?? 0));
//               tempCredit = tempCredit + ((ledger[i].credit ?? 0));
//             }
//             var tempopbala = (ledger[0].opBal ?? 0);
//             tempBal = tempopbala;
//             tempBal = tempBal + (tempDebit - tempCredit);
//             String formatTempBal =
//                 NumberFormat("#,##0.##", "en_US").format(tempBal);
//             debitValues.add(tempDebit);
//             creditValues.add(tempCredit);
//             balanceValues.add(tempBal);
//             // print(ledger);
//             ////// sum of debit and credit value
//             double sumDebit = 0.0;
//             double sumCredit = 0.0;
//             for (int i = 0; i < ledger.length; i++) {
//               sumDebit += (ledger[i].debit ?? 0);
//               sumCredit += (ledger[i].credit ?? 0);
//             }
//             String formatDebit =
//                 NumberFormat("#,##0.##", "en_US").format(sumDebit);
//             String formatCredit =
//                 NumberFormat("#,##0.##", "en_US").format(sumCredit);
//             String formatOpeningBal =
//                 NumberFormat("#,##0.##", "en_US").format(ledger[0].opBal ?? 0);

//             ///
//             double openingBalance = ledger[0].opBal ?? 0;

//             double balancevalue = openingBalance;

//             return Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10),

//                   Center(
//                     child: Text(
//                       '${ledger[0].name}',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   SizedBox(height: 10),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text.rich(TextSpan(children: [
//                         TextSpan(
//                             text: "From Date:",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: fontGrey)),
//                         TextSpan(
//                             text: "${widget.fromDate}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               // fontWeight: FontWeight.w400,
//                             )),
//                       ])),
//                       Text.rich(TextSpan(children: [
//                         TextSpan(
//                             text: "To Date:",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: fontGrey)),
//                         TextSpan(
//                             text: "${widget.ToDate}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               // fontWeight: FontWeight.w400,
//                             )),
//                       ])),
//                     ],
//                   ),

//                   SizedBox(height: 10),
//                   HeadingCard(context, "Description", "Debit", "Credit",
//                       'Balance', Theme.of(context).colorScheme.primary),
//                   SizedBox(height: 10),
//                   // Divider(thickness: 1, color: Colors.grey),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           'Openning Balance: ${formatOpeningBal.toString()}',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                     ],
//                   ),

//                   SizedBox(height: 10),

//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             // color: Colors.amber,
//                             child: ListView.builder(
//                               itemCount: ledger.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 String? dateRange = ledger[index].vdt;
//                                 String? formattedFromDate;

//                                 if (dateRange != null) {
//                                   final dateParts =
//                                       dateRange.split(" ")[0].split("-");
//                                   final day = int.parse(dateParts[0]);
//                                   final monthAbbreviation = dateParts[1];
//                                   final year = int.parse(dateParts[2]);

//                                   final Map<String, int> monthMap = {
//                                     'JAN': 1,
//                                     'FEB': 2,
//                                     'MAR': 3,
//                                     'APR': 4,
//                                     'MAY': 5,
//                                     'JUN': 6,
//                                     'JUL': 7,
//                                     'AUG': 8,
//                                     'SEP': 9,
//                                     'OCT': 10,
//                                     'NOV': 11,
//                                     'DEC': 12,
//                                   };

//                                   final month = monthMap[monthAbbreviation];

//                                   DateTime fromDateTime =
//                                       DateTime(year, month!, day);
//                                   formattedFromDate =
//                                       "${fromDateTime.day}-${fromDateTime.month}-${fromDateTime.year}";
//                                 }
//                                 // double debit = debitValues[index];
//                                 // double credit = creditValues[index];
//                                 double balance = balanceValues[index];

//                                 NumberFormat formatter =
//                                     NumberFormat("#,##0.##", "en_US");

//                                 String formattedDebit =
//                                     formatter.format(ledger[index].debit);
//                                 String formattedCredit =
//                                     formatter.format(ledger[index].credit);
//                                 String formattedBalance =
//                                     formatter.format(balance);
//                                 return Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.symmetric(
//                                       // vertical: BorderSide(),
//                                       horizontal: BorderSide(
//                                           width: 1, color: Colors.grey),
//                                     )),
//                                     child: PreviewListCard(
//                                       context,
//                                       "${formattedFromDate?.toString() ?? "Date--"}",
//                                       "${ledger.elementAt(index).vtyp?.toString() ?? 'Type --'}",
//                                       "${ledger.elementAt(index).srNo?.toString() ?? 'SRNO --'}",
//                                       formattedDebit,
//                                       "${formattedCredit}",
//                                       "${formattedBalance}",
//                                       "${ledger.elementAt(index).brand?.toString() ?? "--"}",
//                                       "${ledger.elementAt(index).qty?.toDouble()?.truncate().toString() ?? "--"}",
//                                       "${ledger.elementAt(index).rate?.toDouble()?.truncate().toString() ?? "--"}",
//                                     ));
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Spacer(),
//                   MyCard(
//                     title: 'Closing Balance',
//                     color: Theme.of(context).colorScheme.primary,
//                     debit: '$formatDebit',
//                     credit: '$formatCredit',
//                     amount: "$formatTempBal",
//                   )
//                 ],
//               ),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }

//   SizedBox PreviewListCard(
//       context,
//       String? date,
//       String? type,
//       String? name,
//       String? dabit,
//       String? credit,
//       String? balance,
//       String? brand,
//       var qty,
//       var rate,
//       {Callback? ontap}) {
//     return SizedBox(
//       width: double.infinity,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 // elevation: 5,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.09,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   '$date',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     // fontWeight: FontWeight.w600,
//                                     // color: Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 )),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.070),
//                             Align(
//                               // alignment: Alignment.topRight,
//                               child: Text(
//                                 '$type',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   // color: Theme.of(context).colorScheme.onPrimary,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBe tween,
//                           children: [
//                             Expanded(
//                                 child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Text(
//                                   '$brand',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     // fontWeight: FontWeight.w600,
//                                     // color: Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                             Expanded(
//                                 child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 '$qty',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   // fontWeight: FontWeight.w600,
//                                   // color: Theme.of(context).colorScheme.onPrimary,
//                                 ),
//                               ),
//                             )),
//                             Expanded(
//                                 child: Align(
//                               alignment: Alignment.centerRight,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Text(
//                                   '$rate',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     // fontWeight: FontWeight.w600,
//                                     // color: Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                           ],
//                         ),
//                         Align(
//                             alignment: Alignment.bottomLeft,
//                             child: SingleChildScrollView(
//                               child: Text(
//                                 '$name',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   // fontWeight: FontWeight.w600,
//                                   // color: Theme.of(context).colorScheme.onPrimary,
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 // elevation: 5,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.09,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$dabit',
//                             style: TextStyle(
//                               fontSize: 12,

//                               // fontWeight: FontWeight.w600,
//                               // color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 // elevation: 5,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.09,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$credit',
//                             style: TextStyle(
//                               fontSize: 12,

//                               // fontWeight: FontWeight.w600,
//                               // color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 // elevation: 5,
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.09,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                         alignment: Alignment.centerRight,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$balance',
//                             style: TextStyle(
//                               fontSize: 12,

//                               // fontWeight: FontWeight.w600,
//                               // color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   SizedBox HeadingCard(context, String? name, String? dabit, String? credit,
//       String? balance, Color color,
//       {Callback? ontap}) {
//     return SizedBox(
//       width: double.infinity,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 color: color,
//                 elevation: 5,
//                 child: SizedBox(
//                   height: 50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Align(
//                         // alignment: Alignment.center,
//                         child: Column(
//                       children: [
//                         Text(
//                           '$name',
//                           style: TextStyle(
//                             // fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Theme.of(context).colorScheme.onPrimary,
//                           ),
//                         ),
//                         Spacer(),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Text(
//                                   'B',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Text(
//                                   'Q',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Text(
//                                   'R',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         Theme.of(context).colorScheme.onPrimary,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 color: color,
//                 elevation: 5,
//                 child: SizedBox(
//                   height: 50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$dabit',
//                             style: TextStyle(
//                               // fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 color: color,
//                 elevation: 5,
//                 child: SizedBox(
//                   height: 50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$credit',
//                             style: TextStyle(
//                               // fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: ontap,
//               child: Card(
//                 color: color,
//                 elevation: 5,
//                 child: SizedBox(
//                   height: 45,
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             '$balance',
//                             style: TextStyle(
//                               // fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).colorScheme.onPrimary,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saif/services/service.dart';
import 'package:saif/theme/color_scheme.dart';

import '../componets/headingCard.dart';
import '../componets/my_card.dart';
import '../componets/priewcard.dart';
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
  // final dateFormat = DateFormat("dd-MMM-yyyy");

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
            // // String? formatBalance;
            final ledger = snapshot.data;
            ////////////////////////
            List<double> debitValues = [];
            List<double> creditValues = [];
            List<double> balanceValues = [];
            double debitValue = 0.0;
            double creditValue = 0.0;
            for (var i = 0; i < ledger!.length; i++) {
              double balance;

              debitValue = debitValue + ((ledger[i].debit ?? 0));
              creditValue = creditValue + ((ledger[i].credit ?? 0));
              // double debit = double.parse(debitValue);
              // double credit = double.parse(creditValue);

              double opnBalance = ledger[i].opBal!.toDouble();
              balance = opnBalance;

              balance += (debitValue - creditValue);

              debitValues.add(debitValue);
              creditValues.add(creditValue);
              balanceValues.add(balance);
            }
            /////////////////////////
            var tempBal = 0.0;
            var tempDebit = 0.0;
            var tempCredit = 0.0;
            for (var i = 0; i < ledger.length; i++) {
              tempDebit = tempDebit + ((ledger[i].debit ?? 0));
              tempCredit = tempCredit + ((ledger[i].credit ?? 0));
            }
            var tempopbala = (ledger[0].opBal ?? 0);
            tempBal = tempopbala;
            tempBal = tempBal + (tempDebit - tempCredit);
            String formatTempBal =
                NumberFormat("#,##0.##", "en_US").format(tempBal);
            debitValues.add(tempDebit);
            creditValues.add(tempCredit);
            balanceValues.add(tempBal);
            // print(ledger);
            ////// sum of debit and credit value
            double sumDebit = 0.0;
            double sumCredit = 0.0;
            for (int i = 0; i < ledger.length; i++) {
              sumDebit += (ledger[i].debit ?? 0);
              sumCredit += (ledger[i].credit ?? 0);
            }
            String formatDebit =
                NumberFormat("#,##0.##", "en_US").format(sumDebit);
            String formatCredit =
                NumberFormat("#,##0.##", "en_US").format(sumCredit);
            String formatOpeningBal =
                NumberFormat("#,##0.##", "en_US").format(ledger[0].opBal ?? 0);

            ///
            double openingBalance = ledger[0].opBal ?? 0;

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
                      '${ledger[0].name}',
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
                            )),
                      ])),
                    ],
                  ),

                  SizedBox(height: 10),
                  HeadingCard(
                    balance: 'Balance',
                    color: Theme.of(context).colorScheme.primary,
                    context: context,
                    credit: 'Credit',
                    debit: 'Debit',
                    name: 'Description',
                  ),

                  SizedBox(height: 10),

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
                                String? dateRange = ledger[index].vdt;
                                String? formattedFromDate;

                                if (dateRange != null) {
                                  final dateParts =
                                      dateRange.split(" ")[0].split("-");
                                  final day = int.parse(dateParts[0]);
                                  final monthAbbreviation = dateParts[1];
                                  final year = int.parse(dateParts[2]);

                                  final Map<String, int> monthMap = {
                                    'JAN': 1,
                                    'FEB': 2,
                                    'MAR': 3,
                                    'APR': 4,
                                    'MAY': 5,
                                    'JUN': 6,
                                    'JUL': 7,
                                    'AUG': 8,
                                    'SEP': 9,
                                    'OCT': 10,
                                    'NOV': 11,
                                    'DEC': 12,
                                  };

                                  final month = monthMap[monthAbbreviation];

                                  DateTime fromDateTime =
                                      DateTime(year, month!, day);
                                  formattedFromDate =
                                      "${fromDateTime.day}-${fromDateTime.month}-${fromDateTime.year}";
                                }

                                // double debit = debitValues[index];
                                // double credit = creditValues[index];
                                double balance = balanceValues[index];

                                NumberFormat formatter =
                                    NumberFormat("#,##0.##", "en_US");

                                String formattedDebit =
                                    formatter.format(ledger[index].debit);
                                String formattedCredit =
                                    formatter.format(ledger[index].credit);
                                String formattedBalance =
                                    formatter.format(balance);

                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: 1, color: Colors.grey),
                                  )),
                                  child: PreviewListCard(
                                    context: context,
                                    balance: formattedBalance,
                                    brand:
                                        "${ledger.elementAt(index).brand?.toString() ?? "--"}",
                                    credit: formattedCredit,
                                    date: '$formattedFromDate',
                                    debit: formattedDebit,
                                    name:
                                        "${ledger.elementAt(index).srNo?.toString() ?? 'SRNO --'}",
                                    qty:
                                        "${ledger.elementAt(index).qty?.toDouble().truncate().toString() ?? "--"}",
                                    rate:
                                        "${ledger.elementAt(index).rate?.toDouble().truncate().toString() ?? "--"}",
                                    type:
                                        "${ledger.elementAt(index).vtyp?.toString() ?? 'Type --'}",
                                  ),
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
}
