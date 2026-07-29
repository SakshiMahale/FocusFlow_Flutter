import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../models/habit.dart';
import '../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBox = Hive.box<Task>("tasks");
    final habitBox = Hive.box<Habit>("habits");

    final completedTasks = taskBox.values.where((e) => e.completed).length;

    final completedHabits = habitBox.values.where((e) => e.completed).length;

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 15),

            const Text(
              "Sakshi",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const Text(
              "FocusFlow User",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.task_alt,
                            color: Colors.blue,
                            size: 35,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "$completedTasks",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text("Tasks Completed"),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.track_changes,
                            color: Colors.green,
                            size: 35,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "$completedHabits",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text("Habits Done"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              child: SwitchListTile(
                title: const Text("Dark Mode", style: TextStyle(fontSize: 18)),

                secondary: const Icon(Icons.dark_mode),

                value: themeProvider.isDark,

                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),

            const SizedBox(height: 15),

            const Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                subtitle: Text("FocusFlow Version 1.0"),
              ),
            ),

            const SizedBox(height: 15),

            const Card(
              child: ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text("Stay Consistent"),
                subtitle: Text("Small daily progress leads to big success."),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
