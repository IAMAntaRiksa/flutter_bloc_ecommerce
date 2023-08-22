import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_item_detail.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_request_model.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/order/order_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/widgets/snap_widget/snap_widget.dart';
import 'package:flutter_app_ecommerce/ui/widgets/textfield/custome_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = TextEditingController();

    void sendOrders(List<ProductModel> model) {
      final count =
          model.fold<int>(0, (sum, items) => sum + items.attributes!.price);
      final reuestModel = OrderRequestModel(
          data: Data(
        items: model
            .map(
              (e) => OrderItemDetail(
                id: e.id,
                productName: e.attributes!.name,
                price: e.attributes!.price,
                qty: 1,
              ),
            )
            .toList(),
        price: count,
        address: addressController.text,
        courier: "JNE",
        cost: 22000,
        statusOrder: "waitingPayment",
      ));

      context.read<OrderBloc>().add(OrderEvent.getOrder(reuestModel));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "CheckOut",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(70)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Color(0xffEE4D2D)),
        ),
      ),
      body: CheckOutBodyScreen(controllerAddress: addressController),
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<OrderBloc, OrderState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (model) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SnapWebViewScreen(
                            url: model.url!,
                          );
                        },
                      ));
                    },
                  );
                },
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const SizedBox(),
                      loaded: (model) {
                        return ElevatedButton(
                          onPressed: () => sendOrders(model),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: const Color(0xffEE4D2D),
                          ),
                          child: const Text(
                            'Bayar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckOutBodyScreen extends StatefulWidget {
  final TextEditingController controllerAddress;
  const CheckOutBodyScreen({required this.controllerAddress, super.key});

  @override
  State<CheckOutBodyScreen> createState() => _CheckOutBodyScreenState();
}

class _CheckOutBodyScreenState extends State<CheckOutBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setHeight(30), horizontal: setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QCustomeTextField(
            maxLength: 100,
            controller: widget.controllerAddress,
            label: "Address",
            onChanged: (p0) {},
          ),
          Text(
            "Item Product",
            style: styleTitle.copyWith(fontSize: setFontSize(40)),
          ),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loaded: (model) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: model.toSet().toList().length,
                      itemBuilder: (context, index) {
                        final product = model.toSet().elementAt(index);
                        final count = model
                            .where((element) => element.id == product.id)
                            .length;
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(product.attributes!.image)),
                          title: Text(
                            product.attributes!.name,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Text('$count'),
                        );
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
