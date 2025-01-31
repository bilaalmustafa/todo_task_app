import 'package:hive/hive.dart';

part 'task_model.g.dart'; 

@HiveType(typeId: 0) // Unique type ID for of the model
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDaily;

 @HiveField(2)
  bool isCompleted;

   @HiveField(3)
  DateTime lastComplatedDate;
  

  TaskModel({required this.title,  this.isDaily= false, this.isCompleted= false, required this.lastComplatedDate});
}