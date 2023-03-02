import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../componets/dropdown_button.dart';
import '../componets/roundbutton.dart';
import '../componets/text_widget.dart';
import '../componets/textfield.dart';
import '../services/service.dart';

class CustomerReceipts extends StatefulWidget {
  CustomerReceipts({super.key});

  @override
  State<CustomerReceipts> createState() => _CustomerReceiptsState();
}

class _CustomerReceiptsState extends State<CustomerReceipts> {
  String? usid = GetStorage().read('USID');

  final formKey = GlobalKey<FormState>();
  final bankController = TextEditingController();
  final amountController = TextEditingController();
  final bankNameController = TextEditingController();
  bool loading = false;
  bool isloading = false;
  String? _pkCode = "";

  String? _selectedCash = 'Select Cash / Bank';

  String? cashValue = 'C';
  List<DropdownMenuItem<String>> dropItemsCash = [
    DropdownMenuItem<String>(
      child: Text("Select Cash / Bank"),
      value: "Select Cash / Bank",
    ),
    DropdownMenuItem<String>(
      child: Text("Cash"),
      value: "C",
    ),
    DropdownMenuItem<String>(
      child: Text("Bank"),
      value: "B",
    ),
  ];
// //
  //get customer Api
  ///////////////////
  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('x')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    print(s);
  }

  String? _customerValue = "Select Customer";

  // String? selectedCustomerValue ="Select Customer";
  List<String>? customersList = [];
  List<String> pkCodes = [];

  Future<void> _fetchCustomer2() async {
    setState(() {
      isloading = true;
    });
    try {
      final data = await ApiService.get("CustomerBal/GetBalance/");
      if (data != null) {
        List<String> menuItems = [];

        for (var item in data) {
          if (item is Map<String, dynamic> &&
              item.containsKey("NAME") &&
              item.containsKey("PKCODE") &&
              item["NAME"] is String &&
              item["PKCODE"] is String) {
            String name = item['NAME'];
            String pkCode = item['PKCODE'];
            if (!menuItems.contains(name) && !pkCodes.contains(pkCode)) {
              menuItems.add(name);
              pkCodes.add(pkCode);
            }
          }
        }

        setState(() {
          customersList = menuItems;
          isloading = false;
        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      print("An error occurred: $e");
    }
  }
  //////////////////

  postReceiveApi(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      print('form is validate');

      Map<String, dynamic> bodyData = {
        "USID": usid,
        "FKCUST": "$_pkCode",
        "PTYPE": "$_selectedCash",
        "CHQNO": "${bankController.text.trim()}",
        "BNAME": "${bankNameController.text.trim()}",
        "AMOUNT": "${amountController.text.trim()}"
      };

      final response =
          await ApiService.post("CutRcv/PostReceive/", body: bodyData);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        print(responseBody);

        if (responseBody == "Inserted Successfully") {
          clearController();
          setState(() {
            loading = false;
          });
          // Do something if the response is "Inserted Successfully"
          Fluttertoast.showToast(
            msg: 'Post Submit Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          // Get.to(() => MenuScreen());
        } else {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(
            msg: 'Somethings Went Wrong.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          throw Exception("Failed to New Order");
        }
      } else {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(
          msg: 'Server Error Please Try Again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        throw Exception("Failed to load data from API");
      }
    }
  }

  @override
  void initState() {
    _fetchCustomer2();
    super.initState();
  }

  clearController() {
    setState(() {
      _customerValue = "Select Customer";
      _selectedCash = 'Select Cash / Bank';
      bankController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Receipts'),
        elevation: 0,
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    MyTextWidget(
                        text: 'Select Customer',
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(height: 10),
                    DropdownSearch<String>(
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                          ),
                        );
                      },
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: customersList,
                      dropdownSearchDecoration: InputDecoration(
                        iconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        isDense: false,
                        fillColor: Theme.of(context).colorScheme.primary,
                        // labelText: "",
                        hintText: "search here..",
                      ),
                      popupItemDisabled: isItemDisabled,
                      selectedItem: _customerValue,
                      onChanged: (value) {
                        // print(customersList);
                        setState(() {
                          _customerValue = value;
                          print("..customername..$_customerValue");

                          _pkCode = pkCodes[customersList!.indexOf(value!)];
                          print("..pkcode..$_pkCode");
                        });
                      },
                      validator: (value) {
                        if (value == "Select Customer") {
                          return "Please select a customer";
                        }
                        return null;
                      },
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(hintText: 'Search here..'),
                      ),
                    ),
                    SizedBox(height: 20),
                    MydropDownButton(
                      dropDownItems: dropItemsCash,
                      onChanged: (value) {
                        setState(() {
                          _selectedCash = value.toString();
                          print(_selectedCash.toString());
                        });
                      },
                      title: "Select Cash / Bank",
                      validator: (v) {
                        return v == 'Select Cash / Bank'
                            ? "Select a Cash or Bank"
                            : null;
                      },
                      value: _selectedCash,
                    ),
                    Visibility(
                        visible: _selectedCash == "B",
                        child: SizedBox(height: 20)),
                    Visibility(
                      visible: _selectedCash == "B",
                      child: MyTextForm(
                        text: 'Bank Name',
                        containerWidth: double.infinity,
                        hintText: 'Enter Bank Name..',
                        controller: bankNameController,
                        validator: (text) {
                          if (text.toString().isEmpty) {
                            return "Bank Name is required";
                          }
                        },
                      ),
                    ),
                    Visibility(
                        visible: _selectedCash == "B",
                        child: SizedBox(height: 20)),
                    Visibility(
                      visible: _selectedCash == "B",
                      child: MyTextForm(
                        textKeyboardType: TextInputType.number,
                        text: 'Cheque Number',
                        containerWidth: double.infinity,
                        hintText: 'Enter Cheque No..',
                        controller: bankController,
                        validator: (text) {
                          if (text.toString().isEmpty) {
                            return "Cheque Number is required";
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    MyTextForm(
                      textKeyboardType: TextInputType.number,
                      text: 'Amount',
                      containerWidth: double.infinity,
                      hintText: 'Enter Amount..',
                      controller: amountController,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return "Amount is required";
                        }
                      },
                    ),
                    SizedBox(height: 50),
                    RoundButton(
                      loading: loading,
                      width: double.infinity,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onTap: () {
                        postReceiveApi(context);
                        print(_customerValue);
                        print(_pkCode);
                        print(_selectedCash);
                        print(amountController.text);
                        print(bankNameController.text);
                        print(usid);
                      },
                      title: 'Submit',
                    ),
                  ],
                ),
              ),
            )),
    );
  }
}
