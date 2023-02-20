// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

// import '../screens/menu_screen.dart';
// import '../services/service.dart';

// class OrderController extends GetxController {
//   bool loading = false;
//   var quantity = 0.0;
//   var rate = 0.0;

//   final quantityController = TextEditingController();
//   final rateController = TextEditingController();
//   final amountController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   String? customerValue = "Select Customer";
//   List<DropdownMenuItem<String>> dropdownCustomerName = [];
//   Future<void> _fetchCustomer() async {
//     try {
//       final data = await ApiService.get("Order/GetCustomer/");
//       List<DropdownMenuItem<String>> menuItems = [
//         DropdownMenuItem(
//             child: Text("Select Customer"), value: "$customerValue"),
//       ];

//       for (var item in data) {
//         if (item is Map<String, dynamic> &&
//             item.containsKey("NAME") &&
//             item["NAME"] is String) {
//           menuItems.add(DropdownMenuItem(
//               child: Text(item['NAME'] ?? "Select Customer"),
//               value: item['PKCODE'].toString()));
//         }
//       }
//       dropdownCustomerName = menuItems;
//       update();
//     } catch (e) {
//       print("An error occurred: $e");
//     }
//   }

//   String productValue = "Select Product";
//   List<DropdownMenuItem<String>> dropdownProducts = [];

//   Future<void> fetchProduct() async {
//     try {
//       final data = await ApiService.get("Order/GetItem/");
//       List<DropdownMenuItem<String>> menuItems = [
//         DropdownMenuItem(child: Text("Select Product"), value: "$productValue"),
//       ];

//       for (var item in data) {
//         if (item is Map<String, dynamic> &&
//             item.containsKey("NAME") &&
//             item["NAME"] is String) {
//           menuItems.add(DropdownMenuItem(
//               child: Text(item['NAME'] ?? "Select Product"),
//               value: item['PKCODE'].toString()));
//         }
//       }

//       dropdownProducts = menuItems;
//       update();
//     } catch (e) {
//       print("An error occurred: $e");
//     }
//   }

//   void calculateAmount() {
//     try {
//       quantity = double.parse(quantityController.text.trim());
//       rate = double.parse(rateController.text.trim());
//       var amount = quantity * rate;

//       amountController.text = amount.toStringAsFixed(2);
//       print(amountController.text);
//       update();
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   void moveToHome(BuildContext context) async {
//     if (formKey.currentState!.validate()) {
//       loading = true;
//       update();

//       print('form is validate');

//       Map<String, dynamic> bodyData = {
//         "FKCUST": "$customerValue",
//         "FKMAST": "$productValue",
//         "QTY": quantityController.text.trim(),
//         "RATE": rateController.text.trim(),
//         "AMOUNT": amountController.text
//       };

//       final response =
//           await ApiService.post("Order/PostOrder/", body: bodyData);

//       if (response.statusCode == 200) {
//         final responseBody = json.decode(response.body);

//         print(responseBody);

//         if (responseBody == "Inserted Successfully") {
//           loading = false;
//           update();
//           Fluttertoast.showToast(
//             msg: 'Order Intersted Successfully',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//           );
//           Get.to(() => MenuScreen());
//         } else {
//           loading = false;
//           update();
//           Fluttertoast.showToast(
//             msg: 'Somethings Went Wrong.',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//           );
//           throw Exception("Failed to New Order");
//         }
//       }
//     }
//   }

//   @override
//   void onInit() {
//     _fetchCustomer();
//     fetchProduct();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     quantityController.dispose();
//     rateController.dispose();
//     amountController.dispose();
//     super.onClose();
//   }
// }
