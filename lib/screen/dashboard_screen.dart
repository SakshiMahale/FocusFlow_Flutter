import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';
import 'add_task_screen.dart';
import 'focus_timer_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBox = Hive.box<Task>("tasks");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FocusFlow 🚀",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),

        builder: (context, Box<Task> box, _) {
          int totalTasks = box.length;

          int completedTasks = box.values
              .where((task) => task.completed)
              .length;

          double progress = totalTasks == 0 ? 0 : completedTasks / totalTasks;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Good Morning 👋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Let's make today productive!",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),

                const SizedBox(height: 25),

                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        const Text(
                          "Today's Progress",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        LinearProgressIndicator(value: progress, minHeight: 12),

                        const SizedBox(height: 15),

                        Text(
                          "$completedTasks of $totalTasks Tasks Completed",
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final task = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddTaskScreen(),
                            ),
                          );

                          if (task != null) {
                            taskBox.add(task);
                          }
                        },

                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),

                            child: Column(
                              children: const [
                                Icon(
                                  Icons.add_task,
                                  size: 45,
                                  color: Colors.blue,
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "Add Task",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FocusTimerScreen(),
                            ),
                          );
                        },

                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),

                            child: Column(
                              children: const [
                                Icon(
                                  Icons.timer,
                                  size: 45,
                                  color: Colors.deepPurple,
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "Focus Timer",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Recent Tasks",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                if (box.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text("No tasks added yet.")),
                    ),
                  )
                else
                  ...box.values
                      .take(5)
                      .map(
                        (task) => Card(
                          child: ListTile(
                            leading: Icon(
                              task.completed
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: task.completed
                                  ? Colors.green
                                  : Colors.grey,
                            ),

                            title: Text(task.title),

                            subtitle: Text(
                              "${task.category} • ${task.priority}",
                            ),
                          ),
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
