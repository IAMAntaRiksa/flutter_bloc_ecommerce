import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';
import 'package:flutter_app_ecommerce/core/services/product/product_service.dart';
import 'package:flutter_app_ecommerce/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final productService = locator<ProductService>();
  ProductsBloc() : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const _Loading());
      final result = await productService.getRestaurants();
      if (result.error == false) {
        if (result.data!.isNotEmpty) {
          return emit(_Loaded(result.data!));
        } else {
          return emit(const _Empty());
        }
      } else {
        emit(const _Error("failed get products"));
      }
    });
  }
}
