import 'package:go_router/go_router.dart';
import 'package:scholar_chat/feature/auth/presentation/views/login_view.dart';
import 'package:scholar_chat/feature/auth/presentation/views/signin_view.dart';
import 'package:scholar_chat/feature/home/presentation/views/home_view.dart';

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeView()),
    GoRoute(path: '/register', builder: (context, state) => SigninView()),
    GoRoute(path: '/login', builder: (context, state) => LoginView()),
    GoRoute(path: '/home', builder: (context, state) => HomeView()),
  ],
);
