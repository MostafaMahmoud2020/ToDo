import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:todo/shared/styles/my_theme_data.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class showTasksBottomSheet extends StatefulWidget {
  showTasksBottomSheet({super.key});

  @override
  State<showTasksBottomSheet> createState() => _showTasksBottomSheetState();
}

class _showTasksBottomSheetState extends State<showTasksBottomSheet> {
  TextEditingController taskController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Add New Task",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.task_alt,
                    color: primaryColor,
                    size: 25,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Task Title !";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  controller: taskController,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  enableSuggestions: true,
                  autofocus: true,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 12),
                      suffixIconColor: primaryColor,
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey, width: 3)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 3),
                      ),
                      label: Text(
                        "Enter Task",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      suffixIcon: Icon(Icons.description),
                      focusColor: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Task Description !";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  controller: descriptionController,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                      suffixIconColor: primaryColor,
                      errorStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey, width: 3)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryColor, width: 3)),
                      label: Text(
                        "Enter Description",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      suffixIcon: Icon(Icons.info_outline),
                      focusColor: primaryColor),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text("Select Date  ",
                        style: MyThemeData.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                    Icon(
                      Icons.calendar_month_rounded,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showCalender(context);
                },
                child: Text(selectedDate.toString().substring(0, 10),
                    style: MyThemeData.lightTheme.textTheme.bodyLarge
                        ?.copyWith(color: primaryColor),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        TaskModel taskModel = TaskModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            title: taskController.text,
                            description: descriptionController.text,
                            //set time to zero
                            date: DateUtils.dateOnly(selectedDate)
                                .millisecondsSinceEpoch);
                        FirebaseFunctions.addTask(taskModel);

                        Navigator.pop(context);
                        setState(() {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              backgroundColor: primaryColor,
                              message: "Task Added Successfully!",
                            ),
                          );
                        });
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(primaryColor),
                        elevation: MaterialStatePropertyAll(5),
                        //fixedSize: MaterialStatePropertyAll(Size(20, 20)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(7))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Submit",
                            style: MyThemeData.lightTheme.textTheme.bodyLarge
                                ?.copyWith(fontSize: 15, color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.done,
                          size: 25,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  showCalender(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: primaryColor),
                  textTheme: TextTheme(
                      bodySmall: MyThemeData.lightTheme.textTheme.bodyMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 15))),
              child: child!);
        },
        context: context,
        initialDate: selectedDate,
        //date I have selected in dialog
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate == null) {
      return;
    } else {
      selectedDate = chosenDate;
    }
    setState(() {});
  }
}
