part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeVerifyEmailEvent extends HomeEvent {
  final String email;
  HomeVerifyEmailEvent(this.email);
}
