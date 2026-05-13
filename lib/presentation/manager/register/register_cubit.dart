import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit(this.authRepository) : super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(RegisterLoading());

    try {
      await authRepository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        address: address,
      );

      emit(RegisterSuccess());
    } catch (e) {
      // هنا الـ e هي الرسالة اللي جاية من الـ FirebaseErrorHandler
      emit(RegisterError(e.toString()));
    }
  }
}
