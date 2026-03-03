import 'package:fb_test2/screens/home/home.screen.dart';
import 'package:fb_test2/screens/sign_in/sign_in.screen.dart';
import 'package:fb_test2/screens/sign_up/sign_up.screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: SignUpScreen.routeName,
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
  ],
);
