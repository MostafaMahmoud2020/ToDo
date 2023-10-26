import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  late int index;
  UserModel? userModel;
  User? firebaseUser;
  ThemeMode modeApp = ThemeMode.light;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    index = 0;

    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel =
        await FirebaseFunctions.readUserFromFireStore(firebaseUser!.uid);
    notifyListeners();
  }

  changeBody(int value) {
    index = value;
    notifyListeners();
  }

  changeTheme(ThemeMode mode) {
    modeApp = mode;
    notifyListeners();
  }
}
