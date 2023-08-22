// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_ecommerce/ui/screens/home/home_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String title;
  final String desc;
  final DialogType type;
  final Color color;
  const PaymentScreen({
    Key? key,
    required this.title,
    required this.desc,
    required this.type,
    required this.color,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: widget.type,
        animType: AnimType.rightSlide,
        title: widget.title,
        desc: widget.desc,
        btnOkOnPress: () {
          context.push(HomeScreen.routeName);
        },
        btnOkColor: widget.color,
        btnOkText: 'Close',
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
