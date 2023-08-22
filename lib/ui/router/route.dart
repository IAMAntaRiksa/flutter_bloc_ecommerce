import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';
import 'package:flutter_app_ecommerce/ui/screens/account/account_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/cart/cart_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/checkout/checkout_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/home/home_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/auth/auth_screen.dart';
import 'package:go_router/go_router.dart';

final route = GoRouter(
  initialLocation: HomeScreen.routeName,
  routes: [
    GoRoute(
      path: AuthScreen.routeName,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: CartScreen.routeName,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: CheckOutScreen.routeName,
      builder: (context, state) => const CheckOutScreen(),
      redirect: (context, state) async {
        final isLogin = await setToken.isLogin();
        if (isLogin) {
          return null;
        } else {
          return AuthScreen.routeName;
        }
      },
    ),
    GoRoute(
      path: AccountScreen.routeName,
      builder: (context, state) => const AccountScreen(),
      redirect: (context, state) async {
        final isLogin = await setToken.isLogin();
        if (isLogin) {
          return null;
        } else {
          return AuthScreen.routeName;
        }
      },
    ),
  ],
);
