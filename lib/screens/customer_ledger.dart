import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../componets/roundbutton.dart';
import '../componets/text_widget.dart';
import '../componets/textfield.dart';
import '../services/service.dart';
import 'customer_ledger_preview.dart';

class CustomerLedgerScreen extends StatefulWidget {
  CustomerLedgerScreen(
      {super.key, this.selectedCustomerName, this.selectedCustomerId});
  final String? selectedCustomerId;
  final String? selectedCustomerName;

  @override
  State<CustomerLedgerScreen> createState() => _CustomerLedgerScreenState();
}

class _CustomerLedgerScreenState extends State<CustomerLedgerScreen> {
  final formKey = GlobalKey<FormState>();
  String? _pkCode;
  bool isLoading = true;
  final dateFormat = DateFormat("dd-MMM-yyyy");
  final startDateController = TextEditingController();
  final EndDateController = TextEditingController();
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
    try {
      final data = await ApiService.get("CustomerBal/GetBalance/");
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
        isLoading = false;
      });
    } catch (e) {
      print("An error occurred: $e");
    }
  }
  //////////////////

  valueFromPriviouScreen() {
    if (_customerValue != null) {
      setState(() {
        _customerValue = widget.selectedCustomerName;
        _pkCode = widget.selectedCustomerId;
        print(_customerValue = widget.selectedCustomerName);
        print(_pkCode = widget.selectedCustomerId);
      });
    } else {
      setState(() {
        _customerValue = "Select Customer";
      });
    }
  }

  @override
  void initState() {
    _fetchCustomer2();
    valueFromPriviouScreen();

    super.initState();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        controller.text = dateFormat.format(picked);
      });
    }
  }

  _clearController() {
    startDateController.clear();
    EndDateController.clear();
    setState(() {
      _customerValue = "Select Customer";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Ledger"),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
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
                          isDense: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                          // labelText: "",
                          hintText: "search here",
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
                          decoration:
                              InputDecoration(hintText: 'Search here..'),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyTextForm(
                        text: 'Start Date',
                        containerWidth: double.infinity,
                        hintText: 'DD-MM-YYYY',
                        controller: startDateController,
                        validator: (text) {
                          if (text.toString().isEmpty) {
                            return "Start Date is required";
                          }
                        },
                        sufixIcon: IconButton(
                          icon: Icon(
                            Icons.date_range,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                          onPressed: () =>
                              _selectDate(context, startDateController),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyTextForm(
                        text: 'End Date',
                        sufixIcon: IconButton(
                          icon: Icon(
                            Icons.date_range,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                          onPressed: () =>
                              _selectDate(context, EndDateController),
                        ),
                        containerWidth: double.infinity,
                        hintText: 'DD-MM-YYYY',
                        controller: EndDateController,
                        validator: (text) {
                          if (text.toString().isEmpty) {
                            return "End Date is required";
                          }
                        },
                      ),
                      SizedBox(height: 50),
                      RoundButton(
                        width: double.infinity,
                        // loading: loading,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        onTap: () {
                          print(_pkCode);
                          print(startDateController.text);
                          print(EndDateController.text);

                          if (formKey.currentState!.validate()) {
                            if (_customerValue == "Select Customer") {
                              Get.snackbar(
                                'Error Message',
                                'Please select valide value',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.to(CustomeLedgerPreview(
                                fromDate: startDateController.text,
                                ToDate: EndDateController.text,
                                psctd: _pkCode,
                              ));
                              _clearController();
                            }
                          }
                        },
                        title: "Preview",
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
