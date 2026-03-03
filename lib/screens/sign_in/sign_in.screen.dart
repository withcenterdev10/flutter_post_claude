import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = '/sign_in';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  State<StatefulWidget> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "Email")),
            ],
          ),
        ),
      ),
    );
  }
}
