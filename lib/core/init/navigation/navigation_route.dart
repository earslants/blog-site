import 'package:emirhanarslantascom/view/content/view/content_view.dart';
import 'package:flutter/material.dart';
import '../../../view/home/view/home_view.dart';
import '../../components/app/not_found_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const HomeView(), NavigationConstants.DEFAULT);

      case NavigationConstants.CONTENT:
        if (settings.arguments is String) {
          return normalNavigate(
            ContentView(
              id: settings.arguments as String,
            ),
            NavigationConstants.CONTENT,
          );
        } else {
          return notFoundNavigate();
        }
      default:
        return notFoundNavigate();
    }
  }

  MaterialPageRoute notFoundNavigate() => MaterialPageRoute(
        builder: (context) => const NotFoundView(),
      );

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: pageName),
    );
  }
}
