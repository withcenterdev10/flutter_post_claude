import 'package:fb_test2/screens/posts/posts.screen.dart';
import 'package:fb_test2/screens/profile/profile.screen.dart';
import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/services/user/user.service.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: SizedBox.shrink()),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              Navigator.of(context).pop();
              ProfileScreen.push(context);
            },
          ),
          ListTile(
            title: const Text("My Posts"),
            onTap: () {
              Navigator.of(context).pop();
              PostsScreen.push(context);
            },
          ),
          const Spacer(),
          ListTile(
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
    );
  }
}
