import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/sign_up';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await UserService.instance.signUp(
                      emailController.text,
                      passwordController.text,
                    );

                    if (context.mounted) {
                      HomeScreen.go(context);
                    }
                  } catch (error) {
                    debugPrint(error.toString());
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
