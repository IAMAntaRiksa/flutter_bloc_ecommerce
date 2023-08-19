import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';
import 'package:flutter_app_ecommerce/ui/widgets/Product/prodoct_item.dart';

class ProductsListWidget extends StatelessWidget {
  final List<ProductModel> products;
  final bool useHero;
  final bool useReplacement;
  const ProductsListWidget({
    super.key,
    required this.products,
    this.useHero = true,
    this.useReplacement = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        final ProductModel product = products[index];
        return ProductItem(product: product, userHero: useHero, onClick: () {});
      },
    );
  }
}
