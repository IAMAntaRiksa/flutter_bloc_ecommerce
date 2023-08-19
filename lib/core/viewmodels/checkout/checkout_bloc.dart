import 'package:bloc/bloc.dart';
import 'package:flutter_app_ecommerce/core/models/product/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddToCart>((event, emit) {
      final currentState = state as _Loaded;
      emit(const _Loading());
      emit(_Loaded([...currentState.model, event.product]));
    });

    on<_RemoveFroCart>((event, emit) {
      final currentState = state as _Loaded;
      final updatedProducts =
          currentState.model.where((p) => p.id != event.product.id).toList();
      emit(const _Loading());
      emit(_Loaded(updatedProducts));
    });
  }
}
