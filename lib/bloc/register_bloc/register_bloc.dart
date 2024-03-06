import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repo/user_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<Submitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) async{
  emit(state.update(
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
 
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit)async {
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


  Future<void> _onSubmitted(Submitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await _userRepository.registerWithEmailAndPassword(event.email, event.password);
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error.toString()));
    }
  }
}

