part of 'login_bloc.dart';

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged(this.email);
    @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
    @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);

      @override
  List<Object> get props => [email,password];
}

