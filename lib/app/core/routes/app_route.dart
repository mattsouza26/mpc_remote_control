import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mpc_remote_control/app/core/screens/onboard_screen/onboard_screen.dart';
import 'package:mpc_remote_control/app/features/settings/presentation/controller/settings_controller.dart';

import '../../features/file_browser/presentation/ui/screens/file_browser_screen.dart';
import '../../features/manage-servers/presentation/ui/screens/manage_servers_screen.dart';
import '../../features/server/presentation/ui/screens/home_screen.dart';
import '../../features/settings/presentation/ui/screens/edit_custom_controls_screen.dart';
import '../../features/settings/presentation/ui/screens/settings_screen.dart';

class AppRoute {
  static const _initialRoute = '/';
  static const onBoardScreen = "${_initialRoute}onboard-screen";
  static const homeScreen = "${_initialRoute}home-screen";
  static const settingsScreen = "${_initialRoute}settings-screen";
  static const manageServersScreen = "${_initialRoute}manage-servers-screen";
  static const fileBrowserScreen = "${_initialRoute}file-browser-screen";

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter routes = GoRouter(
    redirect: (context, state) {
      final isFirstOpening = GetIt.I.get<SettingsController>().isFirstOpening.value;
      if (isFirstOpening) {
        return onBoardScreen;
      }
      return null;
    },
    initialLocation: homeScreen,
    routes: [
      GoRoute(
        name: onBoardScreen,
        path: onBoardScreen,
        builder: (context, state) => const OnboardScreen(),
      ),
      GoRoute(
        name: homeScreen,
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: settingsScreen,
        path: settingsScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: 'edit-custom-controls-screen',
            path: 'edit-custom-controls-screen',
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const EditCustomControlsScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeIn)),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: fileBrowserScreen,
        path: fileBrowserScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const FileBrowserScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child,
          ),
        ),
      ),
      GoRoute(
        name: manageServersScreen,
        path: manageServersScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ManageServersScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child,
          ),
        ),
      )
    ],
  );
}
