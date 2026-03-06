import 'dart:async';

import 'package:fb_test2/screens/posts/posts.create_post.screen.dart';
import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:fb_test2/widgets/posts/posts.my_posts.dart';
import 'package:fb_test2/widgets/user/user.ready.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  static const String routeName = '/posts';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Future<void> _loadPosts(String? userId) async {
    if (mounted) {
      PostState.of(context).startFetchingPosts();
      final result = await PostService.instance.getPosts(userId: userId);
      if (!mounted) return;
      PostState.of(context).setPosts(result.posts, result.total);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = UserState.of(context).user!.id!;
      _loadPosts(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Posts")),
      body: UserReady(
        yes: () => const PostsMyPosts(),
        no: () => const Center(child: Text("Please sign in to see your posts")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreatePostScreen.push(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
