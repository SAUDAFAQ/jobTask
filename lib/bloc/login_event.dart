import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithUserDetails extends LoginEvent {
  final String username;
  final String password;

  const LoginWithUserDetails({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}
