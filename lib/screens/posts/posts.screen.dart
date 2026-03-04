import 'dart:math';

import 'package:fb_test2/widgets/user/posts/user.posts.dart';
import 'package:fb_test2/widgets/user/user_ready.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rand = Random();

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  static const String routeName = '/posts';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  Widget build(BuildContext context) {
    print("Rebuilding posts screen");
    return Scaffold(
      appBar: AppBar(title: Text("User posts")),
      body: Center(
        child: UserReady(
          yes: () {
            return UserPosts(
              builder: (context, posts) {
                if (posts.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            DatabaseReference postListRef = FirebaseDatabase
                                .instance
                                .ref("members")
                                .child("cOqaUnIKgkWcKDPYXBalYsfoVVp2")
                                .child("posts");

                            DatabaseReference newPostRef = postListRef.push();
                            newPostRef.update({
                              "title": "post title ${rand.nextInt(1000)}",
                            });
                          },
                          child: Text("Add random post"),
                        ),

                        ...posts.map((post) {
                          return Text("Title: ${post['title']}");
                        }),
                      ],
                    ),
                  );
                } else {
                  return Text("No posts found :<");
                }
              },
            );
          },
        ),
      ),
    );
  }
}
