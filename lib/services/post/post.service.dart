import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/repositories/post/post.repository.dart';

class PostService {
  PostService._();

  static final _instance = PostService._();
  static PostService get instance => _instance;

  final PostRepository _repository = PostRepository.instance;

  Future<PostModel> createPost({
    required String userId,
    required String title,
    required String body,
  }) async {
    final model = PostModel(userId: userId, title: title, body: body);
    return await _repository.createPost(model);
  }
}
