import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/router/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholar_chat/feature/auth/cubits/login_cubit/login_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
      create: (context) => LoginCubit(),
      child: const ScholarChat(),
    ),
  );
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),

      routerConfig: goRouter,
    );
  }
}
