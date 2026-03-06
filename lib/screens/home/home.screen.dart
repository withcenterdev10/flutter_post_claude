import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/widgets/home/home.drawer.dart';
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
      endDrawer: const HomeDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          UserReady(
            yes: () => UserData(
              builder: (context, user) {
                final initials = ((user?.name ?? '').length >= 2
                        ? user!.name!.substring(0, 2)
                        : (user?.name ?? '??'))
                    .toUpperCase();
                return Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: CircleAvatar(child: Text(initials)),
                  ),
                );
              },
            ),
            no: () => TextButton(
              onPressed: () => SignInScreen.push(context),
              child: const Text("Sign In"),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("POSTS"),
      ),
    );
  }
}
