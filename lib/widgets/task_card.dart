import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      child: ListTile(
        title: Text(
          task.title,

          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Text("${task.category} • ${task.priority}"),

        trailing: Icon(task.completed ? Icons.done : Icons.pending),
      ),
    );
  }
}
