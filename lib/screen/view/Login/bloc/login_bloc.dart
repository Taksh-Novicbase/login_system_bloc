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
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      log(result.toString());
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
