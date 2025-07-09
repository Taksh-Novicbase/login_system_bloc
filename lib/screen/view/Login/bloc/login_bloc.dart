import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(login);
  }

  FutureOr<void> login(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final auth = FirebaseAuth.instance;

      await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final user = auth.currentUser;

      if (user != null && user.emailVerified) {
        emit(LoginSuccess());
      } else {
        await auth.signOut();
        emit(EmailNotSend());
      }
    } catch (e) {
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }
}
