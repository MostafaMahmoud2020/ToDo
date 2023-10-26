import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (TaskModel value, options) {
        return value.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("User")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (UserModel value, options) {
        return value.toJson();
      },
    );
  }

  // static Future<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
  //   return getTasksCollection().where("date",isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).get();
  // }
  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime dateTime) {
    return getTasksCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static void addTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    var documentRef = collection.doc();
    taskModel.id = documentRef.id;
    documentRef.set(taskModel);
  }

  static void deleteTask(String id) {
    getTasksCollection().doc(id).delete();
  }

  static void updateTask(TaskModel taskModel) async {
    await getTasksCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  static Future<void> createUserWithEmailAndPassword(String name, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.uid != null) {
        UserModel userModel =
            UserModel(id: credential.user!.uid, name: name, email: email);
        addUserToFireStore(userModel).then((value) => onSuccess());
        onSuccess();
      }

      // on FirebaseAuthException its a type of error or exception
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      onError(e);
      print(e);
    }
  }

  static Future<void> addUserToFireStore(UserModel userModel) {
    var collection = getUserCollection();
    var documentRef = collection.doc(userModel.id);
    return documentRef.set(userModel);
  }

  static Future<void> logIn(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        var user = readUserFromFireStore(credential.user!.uid);

        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onError("Wrong Email or Password");
    }
  }

  static Future<UserModel?> readUserFromFireStore(String id) async {
    DocumentSnapshot<UserModel> doc = await getUserCollection().doc(id).get();
    return doc.data();
  }
}

//
