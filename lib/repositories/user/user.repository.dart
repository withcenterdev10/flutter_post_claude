import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/utils/api/api.util.dart';

class UserRepository {
  UserRepository._();

  static final _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<void> signUp(UserModel model) async {
    await ApiUtil.instance.post('/users', data: {
      'email': model.email,
      'password': model.password,
    });
  }

  Future<void> signIn(UserModel model) async {
    await ApiUtil.instance.post('/login', data: {
      'email': model.email,
      'password': model.password,
    });
  }

  Future<void> updateUser(UserModel model) async {}

  Future<void> signOut() async {}
}
