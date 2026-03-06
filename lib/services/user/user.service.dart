import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/repositories/user/user.repository.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  final UserRepository _repository = UserRepository.instance;

  Future<UserModel> signIn(String email, String password) async {
    final model = UserModel(email: email, password: password);
    return await _repository.signIn(model);
  }

  Future<UserModel> signUp(String email, String password) async {
    final model = UserModel(email: email, password: password);
    return await _repository.signUp(model);
  }

  Future<UserModel?> fetchUser(String id) async {
    return await _repository.fetchUser(id);
  }

  Future<UserModel> updateUser({
    required String id,
    required String name,
    required String gender,
  }) async {
    final model = UserModel(id: id, name: name, gender: gender);
    return await _repository.updateUser(model);
  }

  Future<void> signOut(UserModel model) async {
    await _repository.signOut(model);
  }
}