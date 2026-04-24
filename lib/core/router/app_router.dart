import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/backlog/presentation/backlog_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/onboarding/presentation/settings_screen.dart';
import '../../features/pact/presentation/archive_screen.dart';
import '../../features/pact/presentation/pact_creation_screen.dart';
import '../../features/pact/presentation/pact_detail_screen.dart';
import '../../features/pause_drawer/presentation/pause_drawer_screen.dart';

// Route path constants — use these instead of string literals throughout the app.
abstract final class AppRoutes {
  static const dashboard = '/';
  static const pactCreate = '/pact/create';
  static const pactDetail = '/pact/:id';
  static const backlog = '/backlog';
  static const pauseDrawer = '/pause-drawer';
  static const archive = '/archive';
  static const settings = '/settings';

  static String pactDetailPath(String id) => '/pact/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.pactCreate,
        builder: (context, state) => const PactCreationScreen(),
      ),
      GoRoute(
        path: AppRoutes.pactDetail,
        builder: (context, state) => PactDetailScreen(
          pactId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.backlog,
        builder: (context, state) => const BacklogScreen(),
      ),
      GoRoute(
        path: AppRoutes.pauseDrawer,
        builder: (context, state) => const PauseDrawerScreen(),
      ),
      GoRoute(
        path: AppRoutes.archive,
        builder: (context, state) => const ArchiveScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
