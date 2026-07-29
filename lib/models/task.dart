import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String category;

  @HiveField(2)
  String priority;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  bool completed;

  Task({
    required this.title,

    required this.category,

    required this.priority,

    required this.date,

    this.completed = false,
  });
}
