import 'package:fb_test2/router.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> test() async {
  DatabaseReference postListRef = FirebaseDatabase.instance
      .ref("members")
      .child("cOqaUnIKgkWcKDPYXBalYsfoVVp2")
      .child("posts");

  DatabaseReference newPostRef = postListRef.push();
  newPostRef.update({"title": "post title 5"});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await test();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
