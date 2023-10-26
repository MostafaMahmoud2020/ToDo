import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/provider.dart';
import 'package:todo/screens/login/login_screen.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';

import '../../layout/home_layout.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/my_theme_data.dart';

class SignUpTab extends StatelessWidget {
  SignUpTab({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              controller: nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  labelText: 'Name',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  labelText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              controller: passwordController,
              decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  labelText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(primaryColor)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onSuccess() {
                    pro.initUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayout.routeName, (route) => false);
                  }

                  onError(errorMessage) {
                    showDialog(
                      barrierDismissible: false,
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

                  FirebaseFunctions.createUserWithEmailAndPassword(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      onSuccess,
                      onError);
                }
              },
              child: Text('Sign Up',
                  style: MyThemeData.lightTheme.textTheme.bodyLarge
                      ?.copyWith(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
