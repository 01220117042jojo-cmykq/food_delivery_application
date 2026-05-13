import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/core/resources/constants_manager.dart';

import '../../../common/widgets.dart';
import '../../../manager/register/register_cubit.dart';
import '../../../manager/register/register_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField(
                  label: AppConstants.labelTextName,
                  hint: AppConstants.hintTextName,
                  controller: _nameController,
                ),
                buildTextFormField(
                  label: AppConstants.labelTextEmail,
                  hint: AppConstants.hintTextEmail,
                  controller: _emailController,
                ),
                buildTextFormField(
                  label: AppConstants.labelTextPassword,
                  hint: AppConstants.hintTextPassword,
                  isPassword: true,
                  controller: _passwordController,
                ),
                buildTextFormField(
                  label: AppConstants.labelTextPhone,
                  hint: AppConstants.hintTextPhone,
                  controller: _phoneController,
                  type: TextInputType.phone,
                ),
                buildTextFormField(
                  label: AppConstants.labelTextAddress,
                  hint: AppConstants.hintTextAddress,
                  controller: _addressController,
                ),

                const SizedBox(height: 20),
                buildSubmitButton(
                  title: AppConstants.signUp,
                  isLoading: state is RegisterLoading,
                  onPressed: () => context.read<RegisterCubit>().register(
                    email: _emailController.text.trim(),
                    password: _passwordController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    address: _addressController.text,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
