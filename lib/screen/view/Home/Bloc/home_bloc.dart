import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on<HomeVerifyEmailEvent>(homeVerifyEmailEvent);
  }

  // FutureOr<void> homeVerifyEmailEvent(
  //   HomeVerifyEmailEvent event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   try {
  //     emit(HomeLoading());
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       emit(HomeError("No user found."));
  //     } else if (user.emailVerified) {
  //       emit(HomeVerified());
  //     } else {
  //       await user.sendEmailVerification();
  //       emit(HomeEmailSent());
  //     }
  //   } catch (e) {
  //     emit(HomeError("Failed to send email: ${e.toString()}"));
  //   }
  // }
}
