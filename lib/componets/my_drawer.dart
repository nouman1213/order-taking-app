import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saif/componets/text_widget.dart';
import 'package:saif/screens/about_us.dart';
import 'package:saif/screens/recieptList.dart';

import '../screens/customer_balance_screen.dart';
import '../screens/customer_ledger.dart';
import '../screens/customer_receipts.dart';
import '../screens/new_order.dart';
import '../screens/orderlist_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _box = GetStorage();

  final _key = 'isDarkMode';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            // color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.shadow,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/admin.png'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MyTextWidget(
                  text: "Admin",
                  size: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                // SizedBox(height: 10),
                MyTextWidget(
                  text: "Admin@gmail.com",
                  // color: Colors.white,
                  size: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 2),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(children: [
                  SwitchListTile(
                      title: MyTextWidget(
                        text: 'Change Theme',
                        // color: blackColor,
                      ),
                      value: theme == ThemeMode.dark,
                      onChanged: (v) => switchTheme()),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Order List',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderListScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Reciepts List',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReceiptListScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'New Order',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewOrderListScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Customer Balance',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerBAlanceScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Customer Ledger',
                    ),
                    // leading: Icon(Icons.home, color: fontGrey),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerLedgerScreen(
                                  selectedCustomerName: "Select Customer",
                                  selectedCustomerId: "Select Customer",
                                )),
                      );
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Customer Receipts',
                    ),
                    // leading: Icon(Icons.home, color: fontGrey),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Get.to(() => CustomerReceipts(),
                          transition: Transition.leftToRightWithFade);
                    },
                  ),
                  ListTile(
                    title: MyTextWidget(
                      text: 'Abous US',
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 1));
                      Get.to(() => AboutUs(),
                          transition: Transition.leftToRightWithFade);
                    },
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
