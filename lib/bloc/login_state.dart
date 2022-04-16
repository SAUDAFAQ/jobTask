import 'package:equatable/equatable.dart';

enum LoginRequestStatus { notStarted, success, failed, inProgress }

class LoginState extends Equatable {
  final LoginRequestStatus loginStatus;
  final String username;
  final String password;
  final response;

  const LoginState(
      {this.loginStatus = LoginRequestStatus.notStarted,
      this.username = '',
      this.password = '',
      this.response = ''});

  @override
  List<Object?> get props => [loginStatus, response, username, password];

  LoginState copyWith(
      {String? response,
      LoginRequestStatus? status,
      String? username,
      String? password}) {
    return LoginState(
        response: response,
        loginStatus: status ?? loginStatus,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
