// lib/presentation/login/login_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_state.dart';
import 'widgets/login_form.dart'; // استيراد الملف الجديد
import 'widgets/signup_form.dart';

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
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepository()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Success!")));
              // Navigator.pushNamed(context, Routes.homeRoute);
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              _buildTopHeader(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    LoginForm(), // الويدجت اللي فصلناه
                    SignUpForm(), // الويدجت اللي فصلناه
                  ],
                ),
              ),
            ],
          ),
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
