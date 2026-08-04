import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/habit.dart';
import 'add_habit_screen.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  late Box<Habit> habitBox;

  @override
  void initState() {
    super.initState();
    habitBox = Hive.box<Habit>("habits");
  }

  int get completedHabits =>
      habitBox.values.where((habit) => habit.completed).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Habit Tracker"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final name = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen()),
          );

          if (name != null && name.toString().trim().isNotEmpty) {
            habitBox.add(Habit(name: name, completed: false));
          }
        },
      ),

      body: ValueListenableBuilder(
        valueListenable: habitBox.listenable(),
        builder: (context, Box<Habit> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No habits added yet.\nClick + to add one.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          double progress = completedHabits / box.length;

          return Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,

                  children: [
                    Card(
                      elevation: 5,

                      child: Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          children: [
                            const Icon(
                              Icons.track_changes,
                              size: 45,
                              color: Colors.green,
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Today's Habit Progress",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                            ),

                            const SizedBox(height: 15),

                            Text(
                              "$completedHabits / ${box.length} Habits Completed",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${(progress * 100).toInt()}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: box.length,

                    itemBuilder: (context, index) {
                      Habit habit = box.getAt(index)!;

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 15),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),

                          child: Row(
                            children: [
                              Checkbox(
                                value: habit.completed,
                                onChanged: (value) {
                                  habit.completed = value!;
                                  habit.save();
                                },
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      habit.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        decoration: habit.completed
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      habit.completed
                                          ? "Completed Today"
                                          : "Pending",
                                      style: TextStyle(
                                        color: habit.completed
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  habit.delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
