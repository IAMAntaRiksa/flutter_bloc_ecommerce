import 'package:bloc/bloc.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_request.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_response.dart';
import 'package:flutter_app_ecommerce/core/services/auth/auth_service.dart';
import 'package:flutter_app_ecommerce/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final authService = locator<AuthServices>();
  RegisterBloc() : super(const _Initial()) {
    on<_GetRegister>((event, emit) async {
      final result = await authService.register(event.model);
      result.fold((l) => emit(_$_Error(l)), (r) => emit(_$_Loaded(r)));
    });
  }
}
