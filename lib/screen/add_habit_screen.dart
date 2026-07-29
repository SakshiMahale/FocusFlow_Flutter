import 'package:flutter/material.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController habitController = TextEditingController();

  String selectedCategory = "Health";
  String selectedFrequency = "Daily";

  final List<String> categories = [
    "Health",
    "Study",
    "Fitness",
    "Personal",
    "Work",
  ];

  final List<String> frequencies = ["Daily", "Weekly", "Monthly"];

  void saveHabit() {
    if (habitController.text.trim().isEmpty) return;

    Navigator.pop(context, habitController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Habit"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Create a New Habit",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: habitController,
              decoration: const InputDecoration(
                labelText: "Habit Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
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
              value: selectedFrequency,
              decoration: const InputDecoration(
                labelText: "Frequency",
                border: OutlineInputBorder(),
              ),
              items: frequencies
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveHabit,
                icon: const Icon(Icons.check),
                label: const Text("Save Habit", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
