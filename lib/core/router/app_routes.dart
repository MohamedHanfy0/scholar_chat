import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scholar_chat/feature/auth/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/feature/auth/cubits/register_cubit/register_cubit.dart';
import 'package:scholar_chat/feature/auth/presentation/views/login_view.dart';
import 'package:scholar_chat/feature/auth/presentation/views/register_view.dart';
import 'package:scholar_chat/feature/chat/cubit/chat_cubit.dart';
import 'package:scholar_chat/feature/chat/presentation/views/chats_view.dart';
GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        if (FirebaseAuth.instance.currentUser == null) {
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginView(),
          );
        } else {
          return BlocProvider(
            create: (context) => ChatCubit()..getMessage(),
            child: ChatView(),
          );
        }
      },
    ),
    GoRoute(
      path: '/register',
      builder:
          (context, state) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterView(),
          ),
    ),
    GoRoute(
      path: '/login',
      builder:
          (context, state) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginView(),
          ),
    ),
    GoRoute(
      path: '/chat',
      builder:
          (context, state) =>
              BlocProvider(create: (context) => ChatCubit()..getMessage(), child: ChatView()),
    ),
  ],
);
