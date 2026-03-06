import 'package:flutter/material.dart';
import 'package:fb_test2/models/post/post.model.dart';
import 'package:provider/provider.dart';

class PostState extends ChangeNotifier {
  List<PostModel>? state;

  static PostState of(BuildContext context) => context.read<PostState>();

  void createPost(PostModel post) {
    state = [...?state, post];
    notifyListeners();
  }
}
