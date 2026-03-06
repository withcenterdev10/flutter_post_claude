import 'package:fb_test2/screens/posts/posts.screen.dart';
import 'package:fb_test2/screens/profile/profile.screen.dart';
import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:fb_test2/widgets/user/user.data.dart';
import 'package:fb_test2/widgets/user/user.ready.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserData(
                    builder: (context, user) {
                      final initials =
                          ((user?.name ?? '').length >= 2
                                  ? user!.name!.substring(0, 2)
                                  : (user?.name ?? '??'))
                              .toUpperCase();
                      return Builder(
                        builder: (context) => IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(child: Text(initials)),
                        ),
                      );
                    },
                  ),

                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Profile"),
              onTap: () {
                Navigator.of(context).pop();
                ProfileScreen.push(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text("My Posts"),
              onTap: () {
                Navigator.of(context).pop();
                PostsScreen.push(context);
              },
            ),

            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                final user = UserState.of(context).user;
                if (user == null) return;

                await UserService.instance.signOut(user);

                if (context.mounted) {
                  UserState.of(context).setUser(null);
                  SignInScreen.go(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
