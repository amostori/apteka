import 'package:apteka/src/features/adding/presentation/adding_screen.dart';
import 'package:apteka/src/features/admin/presentation/admin_home_screen.dart';
import 'package:apteka/src/features/authentication/presentation/custom_profile_screen.dart';
import 'package:apteka/src/features/authentication/presentation/custom_sign_in_screen.dart';
import 'package:apteka/src/features/home/presentation/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers.dart';
import 'go_router_refresh_stream.dart';

enum AppRoute {
  signIn,
  home,
  admin,
  profile,
  adding,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    // the redirect function is only called when we navigate to a new route.
    redirect: (context, state) {
      // redirect() jest wykonywany zawsze gdy przechodzi się na jakąś stronę
      // (route). Jeśli metoda ta zwraca null system kontynuuje przechodzenie
      // na wskazaną stronę tak jakby nic się nie wydarzyło.
      final isLoggedIn = firebaseAuth.currentUser != null;
      if (isLoggedIn) {
        if (state.uri.path == '/sign-in') {
          if (firebaseAuth.currentUser?.email == 'admin@admin.com' ||
              firebaseAuth.currentUser?.email == 'piotr@piotr.com' ||
              firebaseAuth.currentUser?.email == 'bartek@bartek.com') {
            return '/admin';
          } else {
            return '/home';
          }
        }
      } else {
        // Jeśli byłeś na stronie domowej (lub admina) i teraz jesteś
        // wylogowany przenieś mnie do strony z logowaniem (/sign_in)
        if (state.uri.path.startsWith('/home') ||
            state.uri.path.startsWith('/admin')) {
          return '/sign-in';
        }
      }
      return null;
    },
    // if we want to navigate in response to an application state change, we
    // need to use a refreshListenable
    // With this code, the redirect logic will be called every time the
    // authentication state changes
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        builder: (context, state) => const CustomSignInScreen(),
      ),
      GoRoute(
        path: '/admin',
        name: AppRoute.admin.name,
        builder: (context, state) => AdminHomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: AppRoute.profile.name,
            builder: (context, state) => const CustomProfileScreen(),
          ),
          GoRoute(
            path: 'adding',
            name: AppRoute.adding.name,
            builder: (context, state) => AddingMedicine(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
});
