import 'package:flutter/material.dart';

import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController titleController;

  String selectedCategory = "Study";
  String selectedPriority = "Medium";
  DateTime selectedDate = DateTime.now();

  final List<String> categories = ["Study", "Work", "Personal", "Health"];

  final List<String> priorities = ["Low", "Medium", "High"];

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController = TextEditingController(text: widget.task!.title);
      selectedCategory = widget.task!.category;
      selectedPriority = widget.task!.priority;
      selectedDate = widget.task!.date;
    } else {
      titleController = TextEditingController();
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveTask() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a task title.")),
      );
      return;
    }

    final task = Task(
      title: titleController.text.trim(),
      category: selectedCategory,
      priority: selectedPriority,
      date: selectedDate,
      completed: widget.task?.completed ?? false,
    );

    Navigator.pop(context, task);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Add Task" : "Edit Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.task),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
              items: categories
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedPriority,
              decoration: const InputDecoration(
                labelText: "Priority",
                border: OutlineInputBorder(),
              ),
              items: priorities
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPriority = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                trailing: ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Select"),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveTask,
                icon: const Icon(Icons.save),
                label: Text(widget.task == null ? "Save Task" : "Update Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
