import 'package:brandly_01/Screen/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/authprovider.dart';

void main() async {
  // Firebase Initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCF-P5YIdM_K0mak5tie5fyUsaL_YbvUDo",
      appId: "1:931364397769:android:dfbd4d74e3a46f97b46318",
      messagingSenderId: "931364397769",
      projectId: "try-brandl",
    ),
  );

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, title: "Brandly", home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Brandly",
        home: Splash(),
      ),
    );
  }
}
