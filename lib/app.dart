import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/checkout/checkout_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/login/login_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/products/products_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/register/register_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/router/route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (ctx, child) {
          setupScreenUtil(ctx);
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            ),
          );
        },
        routerConfig: route,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
