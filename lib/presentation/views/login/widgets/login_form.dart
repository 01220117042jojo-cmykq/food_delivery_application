import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../presentation/common/widgets.dart';
import '../../../../presentation/resources/routes_manager.dart';
import '../../../manager/login/login_cubit.dart';
import '../../../manager/login/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                    // Navigator.push(context, MaterialPageRoute(builder:
                    //(context) => const ForgotPasswordView()));
                  },
                  child: Text(
                    "Forgot passcode?",
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                buildSubmitButton(
                  title: "Login",
                  isLoading: state is LoginLoading,
                  onPressed: () => context.read<LoginCubit>().login(
                    _emailController.text.trim(),
                    _passwordController.text,
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
