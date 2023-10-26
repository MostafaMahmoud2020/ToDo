import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/providers/provider.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../shared/styles/my_theme_data.dart';

class LoginTab extends StatelessWidget {
  LoginTab({super.key});

  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  errorStyle: TextStyle(fontSize: 13),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email!';
                }
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[com]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return "Please enter valid Email!";
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  labelText: 'Password',
                  errorStyle: TextStyle(fontSize: 13),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password!';
                }
                final bool passwordValid = RegExp(r'^.{6,}$').hasMatch(value);
                if (!passwordValid) {
                  return "Please enter at least 6 characters !";
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColor)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onSuccess() {
                    provider.initUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayout.routeName, (route) => false);
                  }

                  onError(errorMessage) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("$errorMessage"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                return Navigator.pop(context);
                              },
                              child: Text("Ok"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(primaryColor)),
                            )
                          ],
                        );
                      },
                    );
                  }

                  FirebaseFunctions.logIn(emailController.text,
                      passwordController.text, onSuccess, onError);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login',
                      style: MyThemeData.lightTheme.textTheme.bodyLarge
                          ?.copyWith(fontSize: 18, color: Colors.white)),
                  SizedBox(width: 15),
                  Icon(
                    Icons.login_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
