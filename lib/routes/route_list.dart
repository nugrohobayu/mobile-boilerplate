import 'package:go_router/go_router.dart';
import 'package:mobile_boilerplate/features/auth/login/views/login_view.dart';
import 'package:mobile_boilerplate/features/splash_screen.dart';

List<RouteBase> listRoute = [
  /// Tambahkan routename dan halam disini jika akan menggunakan route routeNamed()
  GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  GoRoute(path: LoginView.routeName, builder: (context, state) => const LoginView()),
];
