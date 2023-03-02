import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saif/screens/recieptList.dart';
import '../componets/my_drawer.dart';
import '../componets/my_homecard.dart';
import 'customer_balance_screen.dart';
import 'customer_ledger.dart';
import 'customer_receipts.dart';
import 'new_order.dart';
import 'orderlist_screen.dart';

// ignore: must_be_immutable
class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  List menuList = [
    MyHomeCard(text: 'Orders List', imagePath: "assets/images/orderlist.png"),
    MyHomeCard(
        text: 'Reciepts List', imagePath: "assets/images/receiptList.png"),
    MyHomeCard(text: 'New Order', imagePath: "assets/images/neworder.png"),
    MyHomeCard(
        text: 'Customer Balance', imagePath: "assets/images/balance.png"),
    MyHomeCard(text: 'Customer Ledger', imagePath: "assets/images/ledger.png"),
    MyHomeCard(
        text: 'Customer Receipts', imagePath: "assets/images/receipts.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Menu"),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(menuList.length, (index) {
            return InkWell(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(OrderListScreen(),
                        transition: Transition.leftToRightWithFade);

                    break;
                  case 1:
                    Get.to(ReceiptListScreen(),
                        transition: Transition.leftToRightWithFade);

                    break;
                  case 2:
                    Get.to(NewOrderListScreen(),
                        transition: Transition.leftToRightWithFade);

                    break;
                  case 3:
                    Get.to(CustomerBAlanceScreen(),
                        transition: Transition.leftToRightWithFade);

                    break;
                  case 4:
                    Get.to(
                        CustomerLedgerScreen(
                          selectedCustomerName: "Select Customer",
                        ),
                        transition: Transition.leftToRightWithFade);

                    break;
                  case 5:
                    Get.to(CustomerReceipts(),
                        transition: Transition.leftToRightWithFade);

                    break;
                  default:
                    break;
                }
              },
              child: menuList[index],
            );
          }),
        ),
      ),
    );
  }
}
