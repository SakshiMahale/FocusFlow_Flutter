import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/task.dart';
import 'models/habit.dart';

import 'theme/theme_provider.dart';
import 'screen/splash_screen.dart';
import 'screen/experiment3_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(HabitAdapter());

  // Open Boxes
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Habit>('habits');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const FocusFlowApp(),
    ),
  );
}

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FocusFlow",

      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),

      //home: const SplashScreen(),
      home: const Experiment3Screen(),
    );
  }
}
