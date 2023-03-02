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
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            elevation: 2,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "Customer Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            color: Theme.of(context).colorScheme.primary,
                            elevation: 2,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: receiplist!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _date = receiplist[index].vDATE?.toString() ?? "--";
                        var formatedDate = _date.split("T")[0];
                        var formateAmount = NumberFormat("#,##0.##", "en_US")
                            .format(double.parse(
                                receiplist[index].aMOUNT?.toString() ?? "0"));
                        return receiptListCard(
                            context,
                            receiplist[index].nAME?.toString() ?? "--",
                            // receiplist[index].vDATE?.toString() ?? "--",
                            formatedDate,
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

  SizedBox receiptListCard(BuildContext context, String? title, var date,
      var type, String? amount, Color color) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Card(
              color: color,
              elevation: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "$date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "PTYPE: $type",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "$title",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              color: color,
              elevation: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$amount",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
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
