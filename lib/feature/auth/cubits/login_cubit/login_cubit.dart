import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String pass,
  }) async {
    try {
      emit(LoginLoading());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(message: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(message: 'Wrong password provided for that user.'));
      } else {
        emit(LoginFailure(message: 'Other Error In FB $e'));
      }
    } catch (e) {
      emit(LoginFailure(message: 'Error in $e'));
    }
  }
}
