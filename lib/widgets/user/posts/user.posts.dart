import 'package:fb_test2/utils/database/database.util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key, required this.builder});

  final Widget Function(BuildContext context, List<Map<String, String>>)
  builder;

  @override
  Widget build(BuildContext context) {
    print("Rebuilding");

    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance
          .ref(Lists.members.name)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(Lists.posts.name)
          .onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData) {
          final event = snapshot.data!;
          final dataSnapshot = event.snapshot;

          if (!dataSnapshot.exists) {
            return builder(context, []);
          }

          final List<Map<String, String>> data = [];
          for (final child in dataSnapshot.children) {
            final temp = Map<String, String>.from(
              child.value as Map<dynamic, dynamic>,
            );
            data.add(temp);
          }

          return builder(context, data);
        } else {
          return builder(context, []);
        }
      },
    );
  }
}
