part of 'register_bloc.dart';

 class RegisterState extends Equatable  {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

    bool get isFormValid => isEmailValid && isPasswordValid;
    const RegisterState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });
  factory RegisterState.empty() {
    return const RegisterState(
      email: '',
      password: '',
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
}
    RegisterState update({
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
   RegisterState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
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
class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}

class RegisterSuccess extends RegisterState {}

