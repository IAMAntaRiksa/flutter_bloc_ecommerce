part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.addToCart(ProductModel product) = _AddToCart;
  const factory CheckoutEvent.removeFroCart(ProductModel product) =
      _RemoveFroCart;
}
