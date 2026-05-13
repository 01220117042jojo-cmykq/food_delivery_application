import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_application/presentation/manager/internet/internet_cubit.dart';
import 'package:food_delivery_application/presentation/manager/profile/profile_cubit.dart';
import 'package:food_delivery_application/presentation/manager/register/register_cubit.dart';
import 'package:food_delivery_application/presentation/resources/routes_manager.dart';

import 'data/repositories/auth_repository.dart';
import 'presentation/manager/login/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(authRepository)),
        BlocProvider(create: (context) => RegisterCubit(authRepository)),
        BlocProvider(create: (context) => ProfileCubit(authRepository)),
        BlocProvider(create: (context) => InternetCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}