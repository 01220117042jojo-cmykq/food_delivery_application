import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/core/resources/constants_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/user_model.dart';
import '../../common/widgets.dart';
import '../../manager/profile/profile_cubit.dart';
import '../../manager/profile/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getUserProfile();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFA4A0C)),
            );
          } else if (state is ProfileSuccess) {
            return _buildBody(context, state.user, state);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserModel user, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.myProfile,
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            _buildHeaderRow(context, user),
            _buildUserCard(context, user),
            const SizedBox(height: 20),
            _buildMenuItem(AppConstants.orders, Icons.shopping_cart_outlined),
            _buildMenuItem(
                AppConstants.pendingReviews, Icons.rate_review_outlined),
            _buildMenuItem(AppConstants.faq, Icons.help_outline),
            _buildMenuItem(AppConstants.help, Icons.info_outline),
            const SizedBox(height: 40),
            buildSubmitButton(
              title: AppConstants.update,
              isLoading: state is ProfileLoading,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context, UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppConstants.personalDetails,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            AppConstants.change,
            style: TextStyle(color: Color(0xFFFA4A0C)),
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context, UserModel user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileImageStack(context, user),
          const SizedBox(width: 15),
          _buildUserDetails(user),
        ],
      ),
    );
  }

  Widget _buildProfileImageStack(BuildContext context, UserModel user) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: (user.imageUrl != null && user.imageUrl!.isNotEmpty)
              ? Image.memory(
                  base64Decode(user.imageUrl!),
                  width: 90,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 90,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
        ),
        GestureDetector(
          onTap: () => _showPickerOptions(context),
          child: Container(
            width: 90,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserDetails(UserModel user) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const Divider(),
          Text(
            user.phone,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            user.address,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (builderContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppConstants.takePhoto),
              onTap: () {
                Navigator.pop(builderContext);
                context.read<ProfileCubit>().pickAndUploadImage(
                  ImageSource.camera,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppConstants.uploadFromGallery),
              onTap: () {
                Navigator.pop(builderContext);
                context.read<ProfileCubit>().pickAndUploadImage(
                  ImageSource.gallery,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
