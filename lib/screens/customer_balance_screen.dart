import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:saif/model/customer_balance_mode.dart';
import 'package:saif/services/service.dart';
import 'package:intl/intl.dart';
import 'customer_ledger.dart';

// ignore: must_be_immutable
class CustomerBAlanceScreen extends StatefulWidget {
  CustomerBAlanceScreen({super.key});

  @override
  State<CustomerBAlanceScreen> createState() => _CustomerBAlanceScreenState();
}

class _CustomerBAlanceScreenState extends State<CustomerBAlanceScreen> {
  double? _totalBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Balance"),
        centerTitle: true,
        elevation: 0,

        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: FutureBuilder<List<CustomerBalanceModel>>(
        future: ApiService.getCustomerBalance('CustomerBal/GetBalance/'),
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
            final customers = snapshot.data!;

            _totalBalance = customers.fold(
                0, (sum, customer) => sum! + (customer.balance ?? 0));
            String formattedTotalAmount =
                NumberFormat("#,##0.##", "en_US").format(_totalBalance);
            // print(customers);
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    balanceListCard(context, "Customer Name", "Balance",
                        Theme.of(context).colorScheme.primary),
                    SizedBox(height: 10),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: customers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final customer = customers[index];
                          String formattedAmount =
                              NumberFormat("#,##0.##", "en_US")
                                  .format(customer.balance);

                          return balanceListCard(
                              context,
                              customer.name ?? "Customer Name",
                              // customer.balance.toString(),
                              formattedAmount,
                              Theme.of(context).colorScheme.secondary,
                              ontap: () {
                            Get.to(CustomerLedgerScreen(
                              selectedCustomerName: customers[index].name,
                              selectedCustomerId: customers[index].pkcode,
                            ));
                          });
                        },
                      ),
                    ),
                    Container(
                      child: balanceListCard(
                          context,
                          "Total",
                          formattedTotalAmount,
                          Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 10),
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

  SizedBox balanceListCard(context, String? title, String? Qty, Color color,
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '$title',
                        overflow: TextOverflow.visible,
                        // maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    // child: FittedBox(
                    //   child: MyTextWidget(
                    //     size: 14.0,
                    //     text: '$title',
                    //     color: Theme.of(context).colorScheme.onPrimary,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '$Qty',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  // child: FittedBox(
                  //   child: MyTextWidget(
                  //     text: '$Qty',
                  //     color: Theme.of(context).colorScheme.onPrimary,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
