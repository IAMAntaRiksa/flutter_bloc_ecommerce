import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final VoidCallback onClick;
  final ProductModel product;
  final bool userHero;
  const ProductItem({
    super.key,
    required this.product,
    this.userHero = true,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: setHeight(20),
            horizontal: setWidth(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userHero
                  ? Hero(tag: product.id, child: _imageWidget(context))
                  : _imageWidget(context),
              const SizedBox(
                width: 20,
              ),
              Text(product.attributes!.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: setFontSize(45),
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  product.attributes!.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: setFontSize(40),
                    color: blackColor,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 15,
                  ),
                  SizedBox(
                    width: setWidth(5),
                  ),
                  Expanded(
                    child: Text(
                      product.attributes!.price.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: styleSubtitle.copyWith(
                        fontSize: setFontSize(35),
                        color: blackColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<CheckoutBloc>()
                              .add(CheckoutEvent.removeFroCart(product));
                        },
                        child: const Icon(
                          Icons.remove_circle_outline,
                          size: 18,
                          color: Color(0xffEE4D2D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const SizedBox(),
                              loaded: (model) {
                                final countItem = model
                                    .where((e) => e.id == product.id)
                                    .length;
                                return Text('$countItem');
                              },
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<CheckoutBloc>()
                              .add(CheckoutEvent.addToCart(product));
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          size: 18,
                          color: Color(0xffEE4D2D),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: setHeight(
        isSmallPhoneHeight(context) ? 250 : 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(
            product.attributes!.image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
