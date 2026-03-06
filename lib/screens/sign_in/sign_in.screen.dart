import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/screens/sign_up/sign_up.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/states/user_state.dart';
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
      appBar: AppBar(title: Text("Sign In")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await UserService.instance.signIn(
                        emailController.text,
                        passwordController.text,
                      );

                      if (context.mounted) {
                        UserState.of(context).setUser(user);
                        HomeScreen.go(context);
                      }
                    } catch (error) {
                      debugPrint(error.toString());
                    }
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () {
                    try {
                      SignUpScreen.go(context);
                    } catch (error) {
                      debugPrint(error.toString());
                    }
                  },
                  child: Text("Don't have an account? Sign up instead"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
