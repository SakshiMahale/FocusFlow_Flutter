import 'dart:async';
import 'package:flutter/material.dart';

class FocusTimerScreen extends StatefulWidget {
  const FocusTimerScreen({super.key});

  @override
  State<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends State<FocusTimerScreen> {
  static const int totalSeconds = 25 * 60;

  int remainingSeconds = totalSeconds;

  Timer? timer;

  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;

    isRunning = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();

        setState(() {
          isRunning = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("🎉 Focus Session Completed!")),
        );
      }
    });

    setState(() {});
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  String get timeString {
    int min = remainingSeconds ~/ 60;
    int sec = remainingSeconds % 60;

    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = remainingSeconds / totalSeconds;

    return Scaffold(
      appBar: AppBar(title: const Text("Focus Timer"), centerTitle: true),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),

            child: Column(
              children: [
                const Icon(
                  Icons.self_improvement,
                  size: 70,
                  color: Colors.deepPurple,
                ),

                const SizedBox(height: 15),

                const Text(
                  "Stay Focused",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "One session at a time.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 240,
                  height: 240,

                  child: Stack(
                    alignment: Alignment.center,

                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 12,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.deepPurple,
                            size: 45,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            timeString,
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            isRunning ? "In Progress" : "Ready",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    ElevatedButton.icon(
                      onPressed: isRunning ? null : startTimer,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Start"),
                    ),

                    ElevatedButton.icon(
                      onPressed: isRunning ? pauseTimer : null,
                      icon: const Icon(Icons.pause),
                      label: const Text("Pause"),
                    ),

                    ElevatedButton.icon(
                      onPressed: resetTimer,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: const [
                        Column(
                          children: [
                            Icon(Icons.bolt, color: Colors.orange),
                            SizedBox(height: 8),
                            Text(
                              "25 Min",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Focus"),
                          ],
                        ),

                        Column(
                          children: [
                            Icon(Icons.free_breakfast, color: Colors.green),
                            SizedBox(height: 8),
                            Text(
                              "5 Min",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Break"),
                          ],
                        ),

                        Column(
                          children: [
                            Icon(Icons.repeat, color: Colors.blue),
                            SizedBox(height: 8),
                            Text(
                              "4 Cycles",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Goal"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
