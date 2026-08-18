# my_first_flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

# FocusFlow

FocusFlow is a productivity application built using Flutter that brings together task management, habit tracking, and focus sessions in one place. The goal of this project was to create a simple yet practical application that helps users organize their daily work, build consistent habits, and stay focused using the Pomodoro technique.

The project was developed as part of my learning journey in Flutter while exploring concepts such as local data storage, state management, navigation, and responsive UI design.

---

## Features

### Dashboard

* View daily productivity progress
* Access quick actions for adding tasks and starting focus sessions
* Monitor task completion progress
* View daily schedule and motivational insights

### Task Management

* Add new tasks
* Delete tasks
* Mark tasks as completed
* Organize tasks using categories and priority levels
* Store task data locally using Hive

### Habit Tracker

* Add and manage daily habits
* Track habit completion
* View overall habit progress

### Focus Timer

* Pomodoro-based focus timer
* Start, pause, and reset timer
* Session completion notification

### Profile

* User profile page
* Dark and Light theme support
* Application settings

---

## Technologies Used

* Flutter
* Dart
* Hive Database
* Provider
* Material Design 3

---

## Project Structure

```text
lib/
│
├── models/
├── screen/
├── theme/
├── widgets/
└── main.dart
```

The project is organized into separate folders for models, screens, reusable widgets, and theme management to keep the code clean and maintainable.

---

## Getting Started

### Prerequisites

Before running the application, make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or Visual Studio Code
* Git

You can verify your Flutter installation using:

```
flutter doctor
```

---

## Clone the Repository

```
git clone https://github.com/<your-github-username>/FocusFlow.git
```

Move into the project directory.

```
cd FocusFlow
```

---

## Install Dependencies

```
flutter pub get
```

---

## Generate Hive Files

If you modify the Hive models (`task.dart` or `habit.dart`), regenerate the adapter files using:

```
dart run build_runner build --delete-conflicting-outputs
```

---

## Run the Application

To run the project on the connected device or emulator:

```bash
flutter run
```

To run the application in Chrome:

```bash
flutter run -d chrome
```

To check the available devices:

```bash
flutter devices
```

---

## Building the Project

Generate an Android release APK:

```bash
flutter build apk --release
```

Generate the web version:

```bash
flutter build web
```

---

## How the Application Works

1. The application starts with a splash screen.
2. New users are introduced through the onboarding screen.
3. The dashboard provides a quick overview of daily productivity.
4. Users can create and manage tasks.
5. Habits can be tracked on a daily basis.
6. The focus timer helps users work in dedicated sessions.
7. User preferences such as theme mode are available from the profile page.

---

## Local Storage

FocusFlow stores application data locally using Hive, allowing users to continue using the app even without an internet connection.

The following information is currently stored locally:

* Tasks
* Habits
* Completion status

---

## Future Improvements

There are several features planned for future versions of the application:

* Edit existing tasks
* Search and filter tasks
* Calendar view
* Daily reminders and notifications
* Habit streak tracking
* Productivity analytics
* Export reports
* Cloud synchronization
* User authentication

---

## What I Learned

Working on this project helped me gain practical experience with:

* Flutter application development
* Stateful and Stateless widgets
* Navigation between multiple screens
* Local database integration using Hive
* State management using Provider
* CRUD operations
* Building reusable UI components
* Organizing a Flutter project using a modular structure

---

## Author

**Sakshi Mahale**

This project was built as a personal learning project to strengthen my Flutter development skills by creating a complete productivity application with offline storage and a clean, user-friendly interface.
>>>>>>> 802aa23f592a4160035c41cf7f45b11b1480c400
