import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/products/products_bloc.dart';
import 'package:flutter_app_ecommerce/gen/assets.gen.dart';
import 'package:flutter_app_ecommerce/ui/screens/cart/cart_screen.dart';
import 'package:flutter_app_ecommerce/ui/widgets/Product/product_list.dart';
import 'package:flutter_app_ecommerce/ui/widgets/carousel/carousel.dart';
import 'package:flutter_app_ecommerce/ui/widgets/idle/idle_item.dart';
import 'package:flutter_app_ecommerce/ui/widgets/idle/loading/loading_listview.dart';
import 'package:flutter_app_ecommerce/ui/widgets/search/search_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: _searchWidget(),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselWidgetList(),
            HomeScreenBody(),
          ],
        ),
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
              child: const Icon(
                Icons.home_outlined,
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
                onTap: () {},
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

  Widget _searchWidget() {
    return SearchItem(
      controller: searchController,
      autoFocus: false,
      hintText: "Mau cari apa?",
      color: Colors.white,
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const LoadingListView(),
          error: (data) {
            return Text('Register Error $data');
          },
          loaded: (data) {
            return ProductsListWidget(
              products: data,
            );
          },
          empty: () {
            return IdleNoItemCenter(
              title: "Restaurant not found",
              iconPathSVG: Assets.images.illustrationNotfound.path,
            );
          },
        );
      },
    );
  }
}
