import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/repositories/user/user.repository.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  final UserRepository _repository = UserRepository.instance;

  Future<void> signUp(String email, String password) async {
    final model = UserModel(email: email, password: password);
    await _repository.signUp(model);
  }
}
