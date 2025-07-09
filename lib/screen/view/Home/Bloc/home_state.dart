part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeEmailSent extends HomeState {}

final class HomeVerified extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
