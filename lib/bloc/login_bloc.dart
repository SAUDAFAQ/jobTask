import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/bloc/login_event.dart';
import 'package:job_task/bloc/login_state.dart';

import '../repository/http_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginWithUserDetails) {
        await _handleUserLogin(event, emit);
      }
    });
  }

  _handleUserLogin(LoginWithUserDetails event, Emitter<LoginState> emit) async {
    try {
      final response = await HttpService.getRequest(event.username);
      emit(state.copyWith(
          status: LoginRequestStatus.success, response: response.body));
    } on SocketException catch (e) {
      emit(state.copyWith(status: LoginRequestStatus.failed));
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}
