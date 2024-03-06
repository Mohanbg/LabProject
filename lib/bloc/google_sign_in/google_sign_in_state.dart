part of 'google_sign_in_bloc.dart';



abstract class GoogleSignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignInSuccess extends GoogleSignInState {
  final String displayEmail;

  GoogleSignInSuccess(this.displayEmail);

  @override
  List<Object?> get props => [displayEmail];
}

class GoogleSignInFailure extends GoogleSignInState {
  final String error;

  GoogleSignInFailure(this.error);

  @override
  List<Object?> get props => [error];
}
