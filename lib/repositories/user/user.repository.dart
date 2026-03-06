import 'package:fb_test2/models/user/user.model.dart';
import 'package:fb_test2/utils/api/api.util.dart';

class UserRepository {
  UserRepository._();

  static final _instance = UserRepository._();
  static UserRepository get instance => _instance;

  Future<UserModel> signUp(UserModel model) async {
    final response = await ApiUtil.instance.post('/', data: {
      'email': model.email,
      'password': model.password,
    });
    return UserModel.fromJson(response.data['user']);
  }

  Future<UserModel> signIn(UserModel model) async {
    final response = await ApiUtil.instance.post('/login', data: {
      'email': model.email,
      'password': model.password,
    });
    return UserModel.fromJson(response.data['user']);
  }

  Future<UserModel?> fetchUser(String id) async {
    final response = await ApiUtil.instance.get('/', params: {'id': id});
    return UserModel.fromJson(response.data['user']);
  }

  Future<UserModel> updateUser(UserModel model) async {
    final response = await ApiUtil.instance.put('/', data: {
      'id': model.id,
      'name': model.name,
      'gender': model.gender,
    });
    return UserModel.fromJson(response.data['user']);
  }

  Future<void> signOut(UserModel model) async {
    await ApiUtil.instance.post('/logout', data: {'id': model.id});
  }
}
