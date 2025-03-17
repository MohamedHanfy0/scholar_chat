import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String pass,
  }) async {
    try {
      emit(RegisterLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
            message: 'The account already exists for that email.',
          ),
        );
      } else {
        emit(RegisterFailure(message: 'Error in email or password.'));
      }
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
      // ignore: use_build_context_synchronously
    }
  }
}
