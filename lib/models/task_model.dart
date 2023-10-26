import 'package:todo/models/user_model.dart';

class TaskModel {
  String id;
  String title;
  String description;
  int date;
  String userId;
  bool isDone;

  TaskModel(
      {this.id = "",
      required this.userId,
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  //invoking first constructor and initializing TaskModel
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          userId: json['userId'],
          description: json["description"],
          id: json["id"],
          date: json["date"],
          isDone: json["isDone"],
        );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "userId": userId,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }

// TaskModel fromJson(Map<String, dynamic> json) {
//   return TaskModel(
//     title: json[title],
//     description: json[description],
//     id: json[id],
//     date: json[date],
//     isDone: json[isDone],
//   );
// }
}
