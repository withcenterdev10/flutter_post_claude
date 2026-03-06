import 'package:fb_test2/models/user/user.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState extends ChangeNotifier {
  UserModel? user;

  static UserState of(BuildContext context) => context.read<UserState>();

  void setUser(UserModel? value) {
    user = value;
    notifyListeners();
  }
}
