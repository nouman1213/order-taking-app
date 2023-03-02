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
  final _searchFocusNode = FocusNode();
  bool loading = false;

  List<CustomerBalanceModel>? customerBalanceList;
  List<CustomerBalanceModel>? filteredList;
  final _searchController = TextEditingController();

  //getapi method
  Future<List<CustomerBalanceModel>> getData() async {
    customerBalanceList =
        await ApiService.getCustomerBalance('CustomerBal/GetBalance/');
    filteredList = customerBalanceList;
    return filteredList!;
  }

  // filteredData method
  void searchCustomer(String query) {
    final suggestion = query.isEmpty
        ? customerBalanceList
        : customerBalanceList!.where((element) {
            final name = element.name!.toLowerCase();
            final input = query.toLowerCase();
            return name.contains(input);
          }).toList();
    setState(() {
      filteredList = suggestion;
    });
  }

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
        future: getData(),
        builder: (context, snapshot) {
          bool isSearching = _searchFocusNode.hasFocus;
          if (snapshot.connectionState == ConnectionState.waiting &&
              !isSearching) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data'),
            );
          }
          _totalBalance = customerBalanceList!
              .fold(0, (sum, customer) => sum! + (customer.balance ?? 0));
          String formattedTotalAmount =
              NumberFormat("#,##0.##", "en_US").format(_totalBalance);
          customerBalanceList = snapshot.data;
          return Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextFormField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: searchCustomer,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    hintText: 'Search Customers...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(height: 10),
              balanceListCard(context, "Customer Name", "Balance",
                  Theme.of(context).colorScheme.primary),
              SizedBox(height: 10),
              filteredList!.isEmpty
                  ? Center(
                      child: SizedBox(
                          height: 200,
                          child: Center(child: Text('No data found'))),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredList!.length,
                        itemBuilder: (context, index) {
                          var formateAmount = NumberFormat("#,##0.##", "en_US")
                              .format(double.parse(
                            filteredList![index].balance.toString(),
                          ));
                          CustomerBalanceModel selectedCustomer =
                              filteredList![index];
                          return balanceListCard(
                              context,
                              filteredList![index].name ?? "Customer Name",
                              formateAmount,
                              Theme.of(context).colorScheme.secondary,
                              ontap: () {
                            _searchController.clear();
                            Get.to(
                                CustomerLedgerScreen(
                                  selectedCustomerName: selectedCustomer.name,
                                  selectedCustomerId: selectedCustomer.pkcode,
                                ),
                                transition: Transition.leftToRightWithFade);
                          });
                        },
                      ),
                    ),
              Container(
                child: balanceListCard(
                    context,
                    "Total",
                    '$formattedTotalAmount',
                    Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: 10),
            ],
          );
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
