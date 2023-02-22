import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saif/model/pending_order_model.dart';
import 'package:saif/services/service.dart';

// ignore: must_be_immutable
class OrderListScreen extends StatelessWidget {
  OrderListScreen({super.key});
  String? usid = GetStorage().read("USID");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Orders"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<PendingOrderModel>>(
        future: ApiService.getPendingOrders('ORDER/CustPendigOrdr?usid=$usid'),
        // initialData: InitialData,
        builder: (BuildContext context,
            AsyncSnapshot<List<PendingOrderModel>> snapshot) {
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
            final pendingOreders = snapshot.data;
            print(usid);
            print(pendingOreders);
            return Container(
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
                        child: ListView.builder(
                      itemCount: pendingOreders!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return orderListCard(
                            context,
                            pendingOreders[index].cUSTNAME.toString(),
                            pendingOreders[index].qTY.toString(),
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
                        "$Qty",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
