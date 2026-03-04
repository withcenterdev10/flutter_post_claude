import 'package:fb_test2/models/user/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.builder});

  final Widget Function(BuildContext context, UserModel?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref('members')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .onValue,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final data = (Map<String, dynamic>.from(
            snapshot.data.snapshot.value ?? {},
          ));

          final user = UserModel.fromJson(data);
          return builder(context, user);
        } else {
          return builder(context, null);
        }
      },
    );
  }
}
