import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/repo/user_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) async {
     emit(state.update(
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  Future<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
      emit(state.update(
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }
    bool _isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }
    bool _isPasswordValid(String password) {
    return password.length >= 8 &&
           RegExp(r'(?=.*[A-Z])').hasMatch(password) && // At least one uppercase
           RegExp(r'(?=.*[0-9])').hasMatch(password) && // At least one digit
           RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password); // At least one special character
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _userRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(LoginSuccess(user!));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  } 
}
