# Time Tracking app with Flutter & Firebase

A time tracking application built with Flutter & Firebase: 

![](/.github/images/time-tracker-screenshots.png)

This is intended as a **reference app** based on my [Riverpod Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).

> **Note**: this project used to be called "Started Architecture for Flutter & Firebase" (based on this [old article](https://codewithandrea.com/videos/starter-architecture-flutter-firebase/)). As of January 2023, it follows my updated [Riverpod Architecture](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/), using the latest packages.

## Flutter web preview

A Flutter web preview of the app is available here:

- [Time Tracker | Flutter web demo](https://starter-architecture-flutter.web.app)

## Features

- **Simple onboarding page**
- **Full authentication flow** (using email & password)
- **Jobs**: users can view, create, edit, and delete their own private jobs (each job has a name and hourly rate)
- **Entries**: for each job, user can view, create, edit, and delete the corresponding entries (an entry is a task with a start and end time, with an optional comment)
- **A report page** that shows a daily breakdown of all jobs, hours worked and pay, along with the totals.

All the data is persisted with Firestore and is kept in sync across multiple devices.

## Roadmap

- [ ] Add missing tests
- [x] Stateful Nested Navigation (available since GoRouter 7.1)
- [ ] Use controllers / notifiers consistently across the app (some code still needs to be updated)
- [ ] Add localization
- [ ] Use the new Firebase UI packages where useful
- [ ] Responsive UI

> This is a tentative roadmap. There is no ETA for any of the points above. This is a low priority project and I don't have much time to maintain it.

## Relevant Articles

The app is based on my Flutter Riverpod architecture, which is explained in detail here:

- [Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)
- [Flutter Project Structure: Feature-first or Layer-first?](https://codewithandrea.com/articles/flutter-project-structure/)
- [Flutter App Architecture: The Repository Pattern](https://codewithandrea.com/articles/flutter-repository-pattern/)

More more info on Riverpod, read this:

- [Flutter Riverpod 2.0: The Ultimate Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

## Packages in use

These are the main packages used in the app:

- [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod) for data caching, dependency injection, and more
- [Riverpod Generator](https://pub.dev/packages/riverpod_generator) and [Riverpod Lint](https://pub.dev/packages/riverpod_lint) for the latest Riverpod APIs
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Firebase Auth](https://pub.dev/packages/firebase_auth) and [Firebase UI Auth](https://pub.dev/packages/firebase_ui_auth) for authentication
- [Cloud Firestore](https://pub.dev/packages/cloud_firestore) as a realtime database
- [Firebase UI for Firestore](https://pub.dev/packages/firebase_ui_firestore) for the `FirestoreListView` widget with pagination support
- [RxDart](https://pub.dev/packages/rxdart) for combining multiple Firestore collections as needed
- [Intl](https://pub.dev/packages/intl) for currency, date, time formatting
- [Mocktail](https://pub.dev/packages/mocktail) for testing
- [Equatable](https://pub.dev/packages/equatable) to reduce boilerplate code in model classes

See the [pubspec.yaml](pubspec.yaml) file for the complete list.

## Running the project with Firebase

To use this project with Firebase, follow these steps:

- Create a new project with the Firebase console
- Enable Firebase Authentication, along with the Email/Password Authentication Sign-in provider in the Firebase Console (Authentication > Sign-in method > Email/Password > Edit > Enable > Save)
- Enable Cloud Firestore

Then, follow one of the two approaches below. 👇

### 1. Using the CLI

Make sure you have the Firebase CLI and [FlutterFire CLI](https://pub.dev/packages/flutterfire_cli) installed.

Then run this on the terminal from the root of this project:

- Run `firebase login` so you have access to the Firebase project you have created
- Run `flutterfire configure` and follow all the steps

For more info, follow this guide:

- [How to add Firebase to a Flutter app with FlutterFire CLI](https://codewithandrea.com/articles/flutter-firebase-flutterfire-cli/)

### 2. Manual way (not recommended)

If you don't want to use FlutterFire CLI, follow these steps instead:

- Register separate iOS, Android, and web apps in the Firebase project settings.
- On Android, use `com.example.starter_architecture_flutter_firebase` as the package name.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_android_app) `google-services.json` into `android/app`.
- On iOS, use `com.example.starterArchitectureFlutterFirebase` as the bundle ID.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app) `GoogleService-Info.plist` into `iOS/Runner`, and add it to the Runner target in Xcode.

That's it. Have fun!

## [License: MIT](LICENSE.md)
