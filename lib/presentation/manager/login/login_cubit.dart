import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      await _authRepository.login(email, password);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  //
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(LoginLoading());
    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        address: address,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      emit(LoginError("Please enter your email"));
      return;
    }
    emit(LoginLoading());
    try {
      await _authRepository.forgotPassword(email);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
