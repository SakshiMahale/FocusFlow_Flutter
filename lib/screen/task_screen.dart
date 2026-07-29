import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Box<Task> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>("tasks");
  }

  Color priorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Future<void> addTask() async {
    final Task? task = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );

    if (task != null) {
      await taskBox.add(task);
    }
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Task deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),

      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No Tasks Added Yet 🚀",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: box.length,
            itemBuilder: (context, index) {
              Task task = box.getAt(index)!;

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 15),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),

                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      task.completed = value!;
                      taskBox.putAt(index, task);
                    },
                  ),

                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category : ${task.category}"),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Text("Priority : "),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),

                              decoration: BoxDecoration(
                                color: priorityColor(task.priority),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Text(
                                task.priority,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Due : ${task.date.day}/${task.date.month}/${task.date.year}",
                        ),
                      ],
                    ),
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),

                    onPressed: () {
                      deleteTask(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
