import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.yes, this.no});

  final Widget Function() yes;
  final Widget Function()? no;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return yes();
        } else {
          return no != null ? no!() : const SizedBox.shrink();
        }
      },
    );
  }
}
