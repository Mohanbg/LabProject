
part of 'google_sign_in_bloc.dart';



abstract class GoogleSignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleSignInRequested extends GoogleSignInEvent {}
