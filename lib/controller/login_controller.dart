import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../screens/menu_screen.dart';
import '../services/service.dart';

class AppController extends GetxController {
  final emailContoller = TextEditingController();
  final passContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var loading = false.obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      update();
      var email = emailContoller.text.trim();
      var password = passContoller.text.trim();
      var data =
          await ApiService.get("Account/Getuser?USID=$email&pwd=$password");
      if (data != null) {
        loading.value = false;
        update();

        print(data.toString());
        Fluttertoast.showToast(
          msg: 'Login successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Get.offAll(() => MenuScreen());
      } else {
        Fluttertoast.showToast(
          msg: 'Enter Valid Email and Password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        print(data.toString());
        loading.value = false;
        update();
      }
    }
  }
}
