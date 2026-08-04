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
            // STACK
            Stack(
              alignment: Alignment.bottomRight,

              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white, size: 65),
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              "Sakshi",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "FocusFlow User",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 30),

            // ROW
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 5,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          const Icon(
                            Icons.task_alt,
                            size: 40,
                            color: Colors.blue,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "$completedTasks",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Tasks\nCompleted",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Card(
                    elevation: 5,

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          const Icon(
                            Icons.track_changes,
                            size: 40,
                            color: Colors.green,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "$completedHabits",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Habits\nCompleted",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,

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

            Card(
              elevation: 4,

              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text("Application"),
                subtitle: const Text("FocusFlow Version 1.0"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,

              child: ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text("Daily Motivation"),
                subtitle: const Text(
                  "Small daily progress leads to big success.",
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
