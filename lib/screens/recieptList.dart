import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:saif/model/receipt_list_model.dart';
import 'package:saif/services/service.dart';

// ignore: must_be_immutable
class ReceiptListScreen extends StatelessWidget {
  ReceiptListScreen({super.key});
  String? usid = GetStorage().read("USID");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipts List"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<RecieptListModel>>(
        future: ApiService.getReceiptList('CutRcv/CustRcvList?usid=$usid'),
        // initialData: InitialData,
        builder: (BuildContext context,
            AsyncSnapshot<List<RecieptListModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            print(usid);

            print(snapshot.error);
            return Center(
              child: Text('Something went wrong try lator'),
            );
          }
          if (snapshot.hasData) {
            final receiplist = snapshot.data;
            print(usid);
            print(receiplist);
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    // SizedBox(height: 30),
                    receiptListCard(
                      context,
                      "Customer Name",
                      "Type",
                      "Amount",
                      Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: receiplist!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var formateAmount = NumberFormat("#,##0.##", "en_US")
                            .format(double.parse(
                                receiplist[index].aMOUNT?.toString() ?? "0"));
                        return receiptListCard(
                            context,
                            receiplist[index].nAME?.toString() ?? "--",
                            receiplist[index].pTYPE?.toString() ?? "--",
                            formateAmount,
                            Theme.of(context).colorScheme.secondary);
                      },
                    ))
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  SizedBox receiptListCard(BuildContext context, String? title, String? type,
      String? amount, Color color) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              color: color,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "$title",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
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
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "$type",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              color: color,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "$amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
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
