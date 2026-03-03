import 'package:fb_test2/models/user/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository._();

  static final _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<void> signUp(UserModel model) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
  }
}
