import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserReady extends StatelessWidget {
  const UserReady({super.key, required this.yes, this.no});

  final Widget Function() yes;
  final Widget Function()? no;

  @override
  Widget build(BuildContext context) {
    return Selector<UserState, bool>(
      selector: (_, state) => state.user != null,
      builder: (_, isLoggedIn, _) =>
          isLoggedIn ? yes() : (no?.call() ?? const SizedBox.shrink()),
    );
  }
}
