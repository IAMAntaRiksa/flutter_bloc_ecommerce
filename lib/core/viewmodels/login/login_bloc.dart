import 'package:bloc/bloc.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_request.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_response.dart';
import 'package:flutter_app_ecommerce/core/services/auth/auth_service.dart';
import 'package:flutter_app_ecommerce/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authService = locator<AuthServices>();
  LoginBloc() : super(const _Initial()) {
    on<_GetLogin>((event, emit) async {
      final result = await authService.login(event.model);
      result.fold((l) => emit(_$_Error(l)), (r) => emit(_$_Loaded(r)));
    });
  }
}
