import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_application/core/resources/constants_manager.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../presentation/common/widgets.dart';
import '../../../presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    animate = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAnimation();
    });
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => animate = true);

    //await Future.delayed(const Duration(milliseconds: 3000));
    // ignore: use_build_context_synchronously
    //Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? AppSize.s60 : -AppSize.s100,
            left: AppPadding.p20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorManager.white,
                  radius: AppSize.s40,
                  child: Image.asset(AssetsManager.logo, height: AppSize.s50),
                ),
                const SizedBox(height: AppSize.s20),
                const Text(
                  AppConstants.foodForEveryone,
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                  ),
                ),
              ],
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: 0,
            left: animate ? 0 : -AppSize.s200,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Image.asset(AssetsManager.girl, height: 400),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: 0,
            right: animate ? 0 : -AppSize.s200,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Image.asset(AssetsManager.boy, height: 350),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? AppSize.s40 : -AppSize.s100,
            left: AppPadding.p40,
            right: AppPadding.p40,
            child: buildSubmitButton(
              title: AppConstants.getStarted,
              isLoading: false,
              backgroundColor: Colors.white,
              textColor: ColorManager.primary,
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
