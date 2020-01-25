# Starter Architecture Demo for Flutter & Firebase Realtime Apps

This is a **reference architecture demo** that can be used as a **starting point** for apps using Flutter & Firebase.

## Motivation

Flutter & Firebase is a great combo for getting apps to market in record time.

Without a sound architecture, codebases can quickly become hard to test, maintain, and **reason about**. This **severely** impacts the development speed, and results in buggy products, sad developers and unhappy users.

I have already witnessed this first-hand with various client projects, where the lack of a formal architecture led to days, weeks - even **months** of extra work.

Is "architecture" hard? How can one find the "right" or "correct" Flutter architecture, among the myriad of possible techniques that have flourished over the last two years?

Every app has different requirements, so does the "right" architecture even exist in the first place?

While I don't claim to have a silver bullet, I have refined and fine-tuned a **production-ready** architecture that I have deployed successfully into multiple Flutter & Firebase apps. 

I call this "**Stream-based** Architecture for Flutter & Firebase **Realtime** Apps".

## Stream-based Architecture for Flutter & Firebase Realtime Apps

Two words are key here: **Stream** and **Realtime**.

Unlike with traditional REST APIs, with Firebase we can build **realtime** apps.

That's because Firebase can **push** updates directly to **subscribed** clients when something changes.

For example, widgets can **rebuild** themselves when certain Firestore *documents* or *collections* are updated.

Many Firebase APIs are **inherently** stream-based. As a result, the **simplest** way of making our widgets reactive is to use [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) (or [`StreamProvider`](https://pub.dev/documentation/provider/latest/provider/StreamProvider-class.html)).

Yes, you could use [`ChangeNotifier`](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) or other state mangement techniques that implement observables/listeners. 

But you would need additional "glue" code if you want to "convert" your input streams into reactive models based on `ChangeNotifier`.

> Note: streams are the default way of pushing changes not only with Firebase, but with many other services as well. For example, the [location](https://pub.dev/packages/location) package has an `onLocationChanged()` stream that you can use to get the user's location over time. Whether you use Firestore, or want to get data from your device's input sensors, streams are the most convenient way of delivering **asynchronous** data over time.

A more detailed overview of this architecture is outlined below. But first, here are the goals for this project.

## Project Goals

Define a reference architecture that can be used as a foundation for Flutter apps using Firebase (or other streaming APIs).

This architecture should:

- **minimize mutable state** by adopting an **unidirectional data flow**
- clearly define application layers and their boundaries
- require little boilerplate code

It should also be:

- clear
- simple
- expandable
- testable
- performant
- maintainable

These are all nice properties, but how do they all fit together in practice?

Let's look at the architecture more in detail.

## The application layers

To ensure a good separation of concerns, this architecture defines three distinct layers.

TODO: Add diagram and complete

- Widgets
- ViewModels
- Services

## Demo App: Time Tracker

The demo app is a time tracking application. It is complex enough to capture the various nuances of state management across multiple features. Here is a preview of the main screens:

![](media/time-tracker-screenshots.png)

After signing in, users can view, create, edit and delete their jobs. For each job they can view, create, edit and delete the corresponding entries.

A separate screen shows a daily breakdown of all jobs, hours worked and pay, along with the totals.

All the data is persisted with Firestore, and is kept in sync across multiple devices. 

## Packages

- `firebase_auth` for authentication
- `cloud_firestore` for the remote database
- `provider` for dependency injection and propagating stream values down the widget tree
- `rxdart` for combining multiple Firestore collections as needed
- `intl` for currency, date, time formatting
- `auto_route` for route generation 
- `mockito` for testing

## Widget tree and unidirectional data flow

TODO

## Running the project with Firebase

To use this project with Firebase authentication, some configuration steps are required.

- Create a new project with the Firebase console.
- Add iOS and Android apps in the Firebase project settings.
- On Android, use `com.example.starter_architecture_flutter_firebase` as the package name (a SHA-1 certificate fingerprint is also needed for Google sign-in).
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_android_app) `google-services.json` into `android/app`.
- On iOS, use `com.example.starterArchitectureFlutterFirebase` as the bundle ID.
- then, [download and copy](https://firebase.google.com/docs/flutter/setup#configure_an_ios_app) `GoogleService-Info.plist` into `iOS/Runner`, and add it to the Runner target in Xcode.

See this document for full instructions:

- [https://firebase.google.com/docs/flutter/setup](https://firebase.google.com/docs/flutter/setup) 

## Future Roadmap

TODO

## References

This project borrows many ideas from my Udemy course: [Flutter & Firebase Course: Build a Complete App for iOS & Android](https://www.udemy.com/course/flutter-firebase-build-a-complete-app-for-ios-android/?couponCode=JAN-20), as well as my [Reference Authentication Flow with Flutter & Firebase](https://github.com/bizz84/firebase_auth_demo_flutter).

The Flutter ecosystem keeps evolving, and so does this project. For example, I just recently added [auto_route](https://pub.dev/packages/auto_route), a route generation library that makes navigation super-easy.

By the way, here are some other GitHub projects that also attempt to formalize a good approach to Flutter development:

- [Beyond - An approach to scalable Flutter development](https://github.com/MisterJimson/beyond)
- This [starter app](https://github.com/gregertw/actingweb_firstapp) that includes many different production app features. Related articles: [A Production-Quality Flutter Starter App](https://stuff.greger.io/2019/07/production-quality-flutter-starter-app.html), and [this follow up](https://stuff.greger.io/2020/01/production-quality-flutter-starter-app-take-two.html). 

## [License: MIT](LICENSE.md)