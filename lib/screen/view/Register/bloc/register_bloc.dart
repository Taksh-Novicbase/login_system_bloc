import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>(registerUser);
    on<VerifyEmail>(verifyEmail);
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

void registerUser(RegisterUser event, Emitter<RegisterState> emit) async {
  emit(RegisterLoading());
  try {
    await auth.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    final user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      emit(VerificationEmailSent());
    } else {
      emit(EmailAlreadyVerified());
    }
  } catch (e) {
    emit(Error(e.toString()));
  }
}

FutureOr<void> verifyEmail(
  VerifyEmail event,
  Emitter<RegisterState> emit,
) async {
  emit(RegisterLoading());
  try {
    final user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      emit(VerificationEmailSent());
    } else if (user != null && user.emailVerified) {
      emit(EmailAlreadyVerified());
    } else {
      emit(Error("No user found."));
    }
  } catch (e) {
    emit(Error("Verification failed: ${e.toString()}"));
  }
}
