import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/customer-items_model.dart';
import '../model/customer_balance_mode.dart';
import '../model/getcustomer_model.dart';
import '../model/pending_order_model.dart';

class ApiService {
  static const baseUrl = "http://194.116.228.5:131/Api/";

  static Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$endpoint"));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  static Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl$endpoint"),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  static Future<List<CustomerBalanceModel>> getCustomerBalance(
      String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$endpoint"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => CustomerBalanceModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  static Future<List<CustomerItemsModel>> getCustomerItems(
      String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$endpoint"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => CustomerItemsModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  static Future<List<GetCustomersModel>> getCustomers(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$endpoint"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => GetCustomersModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  // get Pendings order
  static Future<List<PendingOrderModel>> getPendingOrders(
      String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$endpoint"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => PendingOrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load data from API");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
