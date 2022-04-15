import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginWithUsername extends LoginEvent {
  final String username;
  const LoginWithUsername({required this.username});
  @override
  List<Object> get props => [username];
}
