# Starter Architecture Demo for Flutter & Firebase Realtime Apps

This is a **reference architecture demo** that can be used as a **starting point** for apps using Flutter & Firebase.

### Motivation

Flutter & Firebase is a great combo for getting apps to market in record time.

Without a sound architecture, codebases can quickly become hard to test, maintain, and reason about. Ultimately, this **severely** impacts the development speed, resulting in buggy products, sad developers and unhappy users.

I have witnessed this first-hand already with various client projects, where the lack of a formal architecture cost teams days, weeks, even **months** in additional effort.

This can be attributed to many possible causes. How can someone find the "right" or "correct" Flutter architecture, amongst the myriad of possible techniques that have flourished over the last two years?

Beyond that, every app has different requirements, so does the "right" architecture even exist in the first place?

While I don't claim to have a silver bullet, I have refined and fine-tuned a production-ready architecture that I have deployed successfully into multiple Flutter & Firebase apps. 

I will call this "**Stream-based** Architecture for Flutter & Firebase **Realtime** Apps".


## References

This project borrows many ideas from my Udemy course: [Flutter & Firebase Course: Build a Complete App for iOS & Android](https://www.udemy.com/course/flutter-firebase-build-a-complete-app-for-ios-android/?couponCode=JAN-20), as well as my [Reference Authentication Flow with Flutter & Firebase](https://github.com/bizz84/firebase_auth_demo_flutter).

The Flutter ecosystem keeps evolving, and so does this project. For example, I just recently added [auto_route](https://pub.dev/packages/auto_route), a route generation library that makes navigation super-easy.

By the way, here are some other GitHub projects that also attempt to formalize a good approach to Flutter development:

- [Beyond - An approach to scalable Flutter development](https://github.com/MisterJimson/beyond)
- This [starter app](https://github.com/gregertw/actingweb_firstapp) that includes many different production app features. Related articles: [A Production-Quality Flutter Starter App](https://stuff.greger.io/2019/07/production-quality-flutter-starter-app.html), and [this follow up](https://stuff.greger.io/2020/01/production-quality-flutter-starter-app-take-two.html). 

## [License: MIT](LICENSE.md)