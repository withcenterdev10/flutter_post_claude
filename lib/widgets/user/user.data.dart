import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends StatelessWidget {
  const UserData({super.key, required this.builder});

  final Widget Function(BuildContext context, UserModel?) builder;

  @override
  Widget build(BuildContext context) {
    return Selector<UserState, UserModel?>(
      selector: (_, state) => state.user,
      builder: (context, user, _) => builder(context, user),
    );
  }
}
