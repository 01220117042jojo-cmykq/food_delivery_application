// lib/presentation/login/widgets/signup_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../presentation/common/widgets.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField(
                  label: "Full Name",
                  hint: "Marvis Ighedosa",
                  controller: _nameController,
                ),
                buildTextFormField(
                  label: "Email address",
                  hint: "example@gmail.com",
                  controller: _emailController,
                ),
                buildTextFormField(
                  label: "Password",
                  hint: "********",
                  isPassword: true,
                  controller: _passwordController,
                ),
                buildTextFormField(
                  label: "Phone",
                  hint: "+234...",
                  controller: _phoneController,
                  type: TextInputType.phone,
                ),
                buildTextFormField(
                  label: "Address",
                  hint: "No 15 uti street...",
                  controller: _addressController,
                ),

                const SizedBox(height: 20),
                buildSubmitButton(
                  title: "Sign-up",
                  isLoading: state is LoginLoading,
                  onPressed: () => context.read<LoginCubit>().register(
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
