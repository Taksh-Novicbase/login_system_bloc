part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

class VerificationEmailSent extends RegisterState {}

class EmailAlreadyVerified extends RegisterState {}

final class Error extends RegisterState {
  final String message;
  Error(this.message);
}
