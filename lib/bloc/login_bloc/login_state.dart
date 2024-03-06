part of 'login_bloc.dart';

 class LoginState extends Equatable{
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

   bool get isFormValid => isEmailValid && isPasswordValid;
    const LoginState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });
  factory LoginState.empty() {
    return const LoginState(
      email: '',
      password: '',
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

    LoginState update({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      email: email,
      password: password,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
    );
  }
   LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
    @override
  List<Object> get props => [email, password, isEmailValid, isPasswordValid, isSubmitting, isSuccess, isFailure];
 }


class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);
}

