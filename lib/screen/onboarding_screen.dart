import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(Icons.auto_graph, size: 120, color: Colors.deepPurple),

              const SizedBox(height: 30),

              const Text(
                "Welcome to FocusFlow 👋",

                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const Text(
                "Manage tasks, track habits and improve productivity",

                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (context) => const BottomNav()),
                  );
                },

                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
