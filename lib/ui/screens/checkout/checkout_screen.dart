import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/widgets/textfield/custome_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CheckOut"),
      ),
      body: const CheckOutBodyScreen(),
      persistentFooterButtons: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint("Bayar");
                },
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckOutBodyScreen extends StatefulWidget {
  const CheckOutBodyScreen({super.key});

  @override
  State<CheckOutBodyScreen> createState() => _CheckOutBodyScreenState();
}

class _CheckOutBodyScreenState extends State<CheckOutBodyScreen> {
  var controllerAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QCustomeTextField(
            maxLength: 5,
            controller: controllerAddress,
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
                            product.attributes!.name!,
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
