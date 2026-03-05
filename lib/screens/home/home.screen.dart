import 'package:fb_test2/screens/posts/posts.screen.dart';
import 'package:fb_test2/screens/profile/profile.screen.dart';
import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/screens/sign_up/sign_up.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/widgets/user/user.data.dart';
import 'package:fb_test2/widgets/user/user.ready.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);
  static Function(BuildContext context) go = (context) => context.go(routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UserReady(
          no: () => Column(
            mainAxisSize: .min,
            children: [
              ElevatedButton(
                /// sample usage
                /// final someModelIfReturnValIsNeeded = SomeService.instance.someMethod(someData1: 1, someData: 2)
                /// SomeState.of(context).someMethodToUpdateTheState(someModelIfReturnValIsNeeded)
                onPressed: () {
                  SignInScreen.push(context);
                },
                child: Text("Sign In"),
              ),
              ElevatedButton(
                onPressed: () {
                  SignUpScreen.push(context);
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
          yes: () => Column(
            mainAxisSize: .min,
            children: [
              UserData(builder: (context, user) => Text("Name: ${user?.name}")),
              ElevatedButton(
                onPressed: () {
                  UserService.instance.signOut();
                  HomeScreen.go(context);
                },
                child: Text("Sign Out"),
              ),
              ElevatedButton(
                onPressed: () {
                  ProfileScreen.push(context);
                },
                child: Text("Profile"),
              ),
              ElevatedButton(
                onPressed: () {
                  PostsScreen.push(context);
                },
                child: Text("Fetch multiple data page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
