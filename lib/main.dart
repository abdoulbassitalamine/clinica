// import 'package:clinica/screens/home/my_home_page.dart';
import 'package:clinica/widgets/my_app.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// Future<void> main() async {
// //  await Firebase.initializeApp();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( MyApp());
// }
// final navigatorKey = GlobalKey<NavigatorState>();

import 'package:clinica/screens/home/home_page.dart';
import 'package:clinica/screens/home/my_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentification/login_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

// class MyApp extends StatelessWidget {
//   static final String title = 'Firebase Auth';
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     navigatorKey: navigatorKey,
//     debugShowCheckedModeBanner: false,
//     title: title,
//     theme: ThemeData.dark().copyWith(
//       colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
//           .copyWith(secondary: Colors.tealAccent),
//     ),
//     home: MainPage(),
//   );
// }

// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong!'));
//         } else if (snapshot.hasData) {
//           return MyHomePage();
//         } else {
//           return LoginWidget();
//         }
//       },
//     ),
//   );
// }

