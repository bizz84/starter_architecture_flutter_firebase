// // Some introductory articles about integration tests:
// // http://cogitas.net/write-integration-test-flutter/
// // https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337
// // https://stackoverflow.com/questions/52462646/how-to-solve-not-found-dartui-error-while-running-integration-tests-on-flutt
// //
// // Issues with opening the drawer with flutter driver
// // https://github.com/flutter/flutter/issues/9002
// //
// // Rules:
// // - Don't import any flutter code (e.g. material.dart)
// // - Don't import flutter_test.dart

// import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
// // Imports the Flutter Driver API.
// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// void main() {
//   FlutterDriver driver;
//   Future<void> delay([int milliseconds = 250]) async {
//     await Future<void>.delayed(Duration(milliseconds: milliseconds));
//   }

//   // Connect to the Flutter driver before running any tests.
//   setUpAll(() async {
//     driver = await FlutterDriver.connect();
//   });

//   // Close the connection to the driver after the tests have completed.
//   tearDownAll(() async {
//     if (driver != null) {
//       await driver.close();
//     }
//   });

//   test('check flutter driver health', () async {
//     final health = await driver.checkHealth();
//     expect(health.status, HealthStatus.ok);
//   });

//   test('sign in anonymously, sign out', () async {
//     // find and tap anonymous sign in button
//     final anonymousSignInButton = find.byValueKey(Keys.anonymous);
//     // Check to fail early if the auth state is authenticated
//     await driver.waitFor(anonymousSignInButton);
//     await delay(1000); // for video capture
//     await driver.tap(anonymousSignInButton);

//     // Find tab bar and tap on account tab
//     // TODO This does not work. See: https://stackoverflow.com/questions/55460993/flutter-driver-test-bottomnavigationbaritem
//     final tabBar = find.byValueKey(Keys.tabBar);
//     await driver.waitFor(tabBar);
//     await delay(1000); // for video capture
//     await driver.tap(find.byValueKey(Keys.accountTab));

//     // find and tap logout button
//     final logoutButton = find.byValueKey(Keys.logout);
//     await driver.waitFor(logoutButton);
//     await delay(1000); // for video capture
//     await driver.tap(logoutButton);

//     // find and tap confirm logout button
//     final confirmLogoutButton = find.byValueKey(Keys.alertDefault);
//     await driver.waitFor(confirmLogoutButton);
//     await delay(1000); // for video capture
//     await driver.tap(confirmLogoutButton);

//     // try to find anonymous sign in button again
//     await driver.waitFor(anonymousSignInButton);
//   });
// }
