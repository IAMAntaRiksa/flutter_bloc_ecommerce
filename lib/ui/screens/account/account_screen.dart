import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/screens/auth/auth_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/cart/cart_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int _page = 1;
    double bottomBarWidth = 42;
    double bottomBarBorderWidth = 5;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Account",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(70)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await setToken.removeToken();
                // ignore: use_build_context_synchronously
                context.go(AuthScreen.routeName);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFFEE4D2D),
        unselectedItemColor: Colors.black87,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 ? const Color(0xFFEE4D2D) : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () => context.push(HomeScreen.routeName),
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 ? const Color(0xFFEE4D2D) : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () => context.push(AccountScreen.routeName),
                child: const Icon(
                  Icons.person_outline_outlined,
                ),
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 ? const Color(0xFFEE4D2D) : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(
                      orElse: () => const SizedBox(),
                      loaded: (model) {
                        return badges.Badge(
                          badgeStyle: const badges.BadgeStyle(
                              elevation: 0, badgeColor: Colors.white),
                          // elevation: 0,
                          badgeContent: Text(
                            "${model.length}",
                            style: const TextStyle(color: Color(0xffEE4D2D)),
                          ),
                          // badgeColor: Colors.white,
                          child: InkWell(
                            onTap: () => context.push(CartScreen.routeName),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
