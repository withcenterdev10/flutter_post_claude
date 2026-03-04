import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/screens/posts/posts.screen.dart';
import 'package:fb_test2/screens/profile/profile.screen.dart';
import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/screens/sign_up/sign_up.screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: PostsScreen.routeName,
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: SignInScreen.routeName,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: PostsScreen.routeName,
      builder: (context, state) => const PostsScreen(),
    ),
  ],
);
