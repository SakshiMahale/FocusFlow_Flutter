import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.task_alt),

                title: const Text("Tasks Completed"),

                subtitle: const Text("75% completion"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.local_fire_department),

                title: const Text("Current Streak"),

                subtitle: const Text("5 Days"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
