import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../common/ui_helper.dart';
import '../../manager/login/login_cubit.dart';
import '../../manager/login/login_state.dart';
import '../../manager/register/register_cubit.dart';
import '../../manager/register/register_state.dart';
import '../../resources/routes_manager.dart';
import '../register/widgets/signup_form.dart';
import 'widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.showSuccessBar("Login successful");
                Navigator.pushReplacementNamed(context, Routes.mainRoute);
              } else if (state is LoginError) {
                context.showErrorBar(state.message);
              }
            },
          ),
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.showSuccessBar("Account created successfully!");
                Navigator.pushReplacementNamed(context, Routes.mainRoute);
              } else if (state is RegisterError) {
                context.showErrorBar(state.message);
              }
            },
          ),
        ],
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  LoginForm(),
                  SignUpForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          Expanded(child: Image.asset(AssetsManager.logo, height: 130)),
          TabBar(
            controller: _tabController,
            indicatorColor: ColorManager.primary,
            labelColor: ColorManager.black,
            unselectedLabelColor: ColorManager.grey,
            tabs: const [
              Tab(text: "Login"),
              Tab(text: "Sign-up"),
            ],
          ),
        ],
      ),
    );
  }
}
