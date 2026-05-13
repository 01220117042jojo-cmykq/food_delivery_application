import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/presentation/manager/profile/profile_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/auth_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepository;

  ProfileCubit(this.authRepository) : super(ProfileInitial());

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    try {
      final user = await authRepository.getUserData();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfileImage(File image) async {
    emit(ProfileLoading());
    try {
      await authRepository.uploadImage(image);

      await getUserProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> pickAndUploadImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 30,
      );

      if (pickedFile != null) {
        emit(ProfileLoading());

        File imageFile = File(pickedFile.path);

        await authRepository.uploadImage(imageFile);

        await getUserProfile();
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
