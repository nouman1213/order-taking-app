import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saif/controller/login_controller.dart';

import '../componets/roundbutton.dart';
import '../componets/textfield.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appController = Get.put(AppController());

  bool? isObscurText = true;

  @override
  Widget build(BuildContext context) {
    if (appController.isUserLoggedIn) {
      // if user is already logged in, redirect to the main screen
      return MenuScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SAIF",
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: appController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/loginLogo.png",
                  ),
                ),
                SizedBox(height: 10),
                MyTextForm(
                  text: 'Email',
                  textKeyboardType: TextInputType.emailAddress,
                  containerWidth: double.infinity,
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: appController.emailContoller,
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "Email is required";
                    }
                  },
                ),
                SizedBox(height: 10),
                MyTextForm(
                  text: 'Password',
                  containerWidth: double.infinity,
                  hintText: 'Enter your password',
                  obscurText: isObscurText!,
                  sufixIcon: IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: Icon(
                        size: 24,
                        isObscurText!
                            ? Icons.visibility_off
                            : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isObscurText = !isObscurText!;
                      });
                    },
                  ),
                  controller: appController.passContoller,
                  validator: (text) {
                    if (text.toString().isEmpty) {
                      return "Password is required";
                    }
                  },
                ),
                SizedBox(height: 30),
                GetBuilder<AppController>(builder: (_) {
                  return RoundButton(
                    loading: appController.loading.value,
                    width: double.infinity,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: () => appController.login(),
                    title: 'Submit',
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
