import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>(registerUser);
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
    emit(RegisterSuccess());
  } catch (e) {
    emit(RegisterError(e.toString()));
  }
}
