import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/task_model.dart';
import '../../shared/components/appbar.dart';
import '../../shared/firebase/firebase_functions.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/my_theme_data.dart';

class EditScreen extends StatefulWidget {
  EditScreen({super.key});

  static const String routeName = "EditScreen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController taskController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  late TaskModel taskModel;

  reset() {
    taskController = TextEditingController();
    descriptionController = TextEditingController();
  }

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    var args = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;

    taskController.text = args["title"];
    descriptionController.text = args["description"];

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: SharedAppbar(),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Edit Task",
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
                const SizedBox(height: 20),
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
                    enableSuggestions: true,
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    autofocus: false,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 12),
                        suffixIconColor: primaryColor,
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3)),
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
                const SizedBox(height: 20),
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
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3)),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                          TaskModel task = args["taskModel"];
                          task.title = taskController.text;
                          task.description = descriptionController.text;

                          FirebaseFunctions.updateTask(task);

                          Navigator.pop(context);
                          setState(() {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                backgroundColor: primaryColor,
                                message: "Task Updated Successfully!",
                              ),
                            );
                          });
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(primaryColor),
                          elevation: MaterialStatePropertyAll(5),
                          //fixedSize: MaterialStatePropertyAll(Size(20, 20)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(7))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Submit",
                              style: MyThemeData.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                      fontSize: 15, color: Colors.white)),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.done,
                              size: 25,
                              color: Theme.of(context).colorScheme.primary)
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
