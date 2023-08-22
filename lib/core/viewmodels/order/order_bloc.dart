import 'package:bloc/bloc.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_request_model.dart';
import 'package:flutter_app_ecommerce/core/models/order/order_response_model.dart';
import 'package:flutter_app_ecommerce/core/services/order/order_service.dart';
import 'package:flutter_app_ecommerce/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final orderService = locator<OrderService>();
  OrderBloc() : super(const _Initial()) {
    on<_GetOrder>((event, emit) async {
      emit(const _Loading());
      final result = await orderService.orders(event.model);
      return result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
