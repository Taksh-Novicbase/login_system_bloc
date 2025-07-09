part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final String email;
  final String password;

  RegisterUser({required this.email, required this.password});
}
