import 'package:equatable/equatable.dart';

enum LoginRequestStatus { notStarted, success, failed, inProgress }

class LoginState extends Equatable {
  final LoginRequestStatus loginStatus;
  final String username;
  final response;

  const LoginState(
      {this.loginStatus = LoginRequestStatus.notStarted,
      this.username = '',
      this.response = ''});

  @override
  List<Object?> get props => [loginStatus, response, username];

  LoginState copyWith(
      {String? response, LoginRequestStatus? status, String? username}) {
    return LoginState(
        response: response,
        loginStatus: status ?? loginStatus,
        username: username ?? this.username);
  }
}
