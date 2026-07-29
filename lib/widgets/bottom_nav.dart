import 'package:flutter/material.dart';

import '../screen/dashboard_screen.dart';
import '../screen/task_screen.dart';
import '../screen/habit_screen.dart';
import '../screen/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final pages = [
    const DashboardScreen(),

    const TaskScreen(),

    const HabitScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),

          NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),

          NavigationDestination(
            icon: Icon(Icons.track_changes),

            label: "Habits",
          ),

          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
