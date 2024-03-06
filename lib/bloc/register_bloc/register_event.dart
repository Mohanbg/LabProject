part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  Submitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

