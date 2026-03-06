import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/utils/api/api.util.dart';

class PostRepository {
  PostRepository._();

  static final _instance = PostRepository._();
  static PostRepository get instance => _instance;

  Future<PostModel> createPost(PostModel model) async {
    final response = await ApiUtil.instance.post('/posts', data: {
      'user_id': model.userId,
      'title': model.title,
      'body': model.body,
    });
    return PostModel.fromJson(response.data['post']);
  }
}
