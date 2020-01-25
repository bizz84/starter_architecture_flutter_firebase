# Starter Architecture Demo for Flutter & Firebase Realtime Apps

This is a **reference architecture demo** that can be used as a **starting point** for apps using Flutter & Firebase.

### Motivation

Flutter & Firebase is a great combo for getting apps to market in record time.

Without a sound architecture, codebases can quickly become hard to test, maintain, and reason about. Ultimately, this **severely** impacts the development speed, resulting in buggy products, sad developers and unhappy users.

I have witnessed this first-hand already with various client projects, where the lack of a formal architecture cost teams days, weeks, even **months** in additional effort.

This can be attributed to many possible causes. How can someone find the "right" or "correct" Flutter architecture, amongst the myriad of possible techniques that have flourished over the last two years?

Beyond that, every app has different requirements, so does the "right" architecture even exist in the first place?

While I don't claim to have a silver bullet, I have refined and fine-tuned a **production-ready** architecture that I have deployed successfully into multiple Flutter & Firebase apps. 

I will call this "**Stream-based** Architecture for Flutter & Firebase **Realtime** Apps".

## Stream-based Architecture for Flutter & Firebase Realtime Apps

Two words are key here: **Stream** and **Realtime**.

Unlike with traditional REST APIs, with Firebase we can build **realtime** apps.

That's because Firebase can **push** updates directly to clients when something changes.

Using Firestore as an example, we can have certain widgets **rebuild** themselves when certain *documents* or *collections* are updated.

Many Firebase APIs are **inherently** stream-based. As a result, the easiest way to make our widgets reactive is to use `StreamBuilder` (or `StreamProvider`).

Yes, you could use `ChangeNotifier` or other state mangement techniques that implement observables/listeners. 

But you would need additional "glue" code if you want to "convert" your input streams into reactive models based on `ChangeNotifier`.

> Note: streams are the default way of pushing changes not only with Firebase, but with many other services as well. For example, the [location](https://pub.dev/packages/location) package has an `onLocationChanged()` stream that you can use to get the user's location over time. Whether you use Firestore, or want to get data from any of your device's input sensors, streams are the most convenient way of delivering data over time.



This means that our Flutter apps can react to changes
In Flutter, this means that we can have our widgets react to changes 


## References

This project borrows many ideas from my Udemy course: [Flutter & Firebase Course: Build a Complete App for iOS & Android](https://www.udemy.com/course/flutter-firebase-build-a-complete-app-for-ios-android/?couponCode=JAN-20), as well as my [Reference Authentication Flow with Flutter & Firebase](https://github.com/bizz84/firebase_auth_demo_flutter).

The Flutter ecosystem keeps evolving, and so does this project. For example, I just recently added [auto_route](https://pub.dev/packages/auto_route), a route generation library that makes navigation super-easy.

By the way, here are some other GitHub projects that also attempt to formalize a good approach to Flutter development:

- [Beyond - An approach to scalable Flutter development](https://github.com/MisterJimson/beyond)
- This [starter app](https://github.com/gregertw/actingweb_firstapp) that includes many different production app features. Related articles: [A Production-Quality Flutter Starter App](https://stuff.greger.io/2019/07/production-quality-flutter-starter-app.html), and [this follow up](https://stuff.greger.io/2020/01/production-quality-flutter-starter-app-take-two.html). 

## [License: MIT](LICENSE.md)