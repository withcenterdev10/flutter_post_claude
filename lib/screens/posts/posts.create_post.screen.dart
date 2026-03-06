import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  static const String routeName = '/create-post';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) =>
      context.go(routeName);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final post = PostModel(
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
    );
    PostState.of(context).createPost(post);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostState(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Post")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                          ? "Title is required"
                          : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(labelText: "Body"),
                  maxLines: 5,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                          ? "Body is required"
                          : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Create Post"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
