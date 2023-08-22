import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/gen/assets.gen.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/screens/account/account_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/checkout/checkout_screen.dart';
import 'package:flutter_app_ecommerce/ui/screens/home/home_screen.dart';
import 'package:flutter_app_ecommerce/ui/widgets/idle/idle_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int _page = 2;
    double bottomBarWidth = 42;
    double bottomBarBorderWidth = 5;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Cart",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(80)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: setHeight(30),
          ),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loaded: (model) {
                  if (model.isEmpty) {
                    return IdleNoItemCenter(
                      title: "Keranjang Kosong",
                      iconPathSVG: Assets.images.illustrationNotfound.path,
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: model.toSet().toList().length,
                      itemBuilder: (context, index) {
                        final product = model.toSet().elementAt(index);
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    product.attributes!.image,
                                    fit: BoxFit.fitWidth,
                                    height: 135,
                                    width: 135,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          product.attributes!.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 5,
                                        ),
                                        child: Text(
                                          'Rp. ${product.attributes!.price}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "${product.attributes!.description.length >= 20 ? product.attributes!.description.substring(0, 20) : product.attributes!.description}....",
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: const Text(
                                          'In Stock',
                                          style: TextStyle(
                                            color: Colors.teal,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                  CheckoutEvent.removeFroCart(
                                                    product,
                                                  ),
                                                );
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1.5),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: BlocBuilder<CheckoutBloc,
                                                CheckoutState>(
                                              builder: (context, state) {
                                                return state.maybeWhen(
                                                    orElse: () =>
                                                        const SizedBox(),
                                                    loaded: (model) {
                                                      final countItem = model
                                                          .where((element) =>
                                                              element.id ==
                                                              product.id)
                                                          .length;
                                                      return Text('$countItem');
                                                    });
                                              },
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context.read<CheckoutBloc>().add(
                                                  CheckoutEvent.addToCart(
                                                    product,
                                                  ),
                                                );
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
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
                onTap: () {
                  context.push(HomeScreen.routeName);
                },
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
                    },
                  );
                },
              ),
            ),
            label: '',
          ),
        ],
      ),
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: setWidth(24)),
                  child: const Text(
                    'Subtotal ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                        orElse: () => const SizedBox(),
                        loaded: (model) {
                          final total = model.fold(
                            0,
                            (sum, item) => sum + item.attributes!.price,
                          );
                          return Text(
                            'Rp $total',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  context.push(CheckOutScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xffEE4D2D),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
