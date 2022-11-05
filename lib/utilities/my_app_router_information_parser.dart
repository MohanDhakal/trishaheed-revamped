import 'package:flutter/cupertino.dart';
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/route_names.dart';

class MyAppRouterInformationParser
    extends RouteInformationParser<MyAppConfiguration> {
  @override
  RouteInformation? restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.homePage) {
      return RouteInformation(location: RouteName.home);
    } else if (configuration.staffPage) {
      return RouteInformation(location: RouteName.staff);
    } else if (configuration.students) {
      return RouteInformation(location: RouteName.students);
    } else if (configuration.imageGallery) {
      return RouteInformation(location: RouteName.photoGallery);
    } else if (configuration.videoGallery) {
      return RouteInformation(location: RouteName.videoGallery);
    } else if (configuration.extras) {
      return RouteInformation(location: RouteName.extras);
    } else if (configuration.contact) {
      return RouteInformation(location: RouteName.contact);
    } else if (configuration.downloads) {
      return RouteInformation(location: RouteName.downloads);
    } else {
      return RouteInformation(location: RouteName.unknown);
    }
  }

  @override
  Future<MyAppConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.length == 0) {
      return MyAppConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      return switchFirstPage(first);
    } else if (uri.pathSegments.length == 2) {
      // final second = uri.pathSegments[1].toLowerCase();
      return MyAppConfiguration.unknown();
      // return switchSecondPage(second);
    } else
      return MyAppConfiguration.unknown();
  }

  MyAppConfiguration switchFirstPage(String routeName) {
    print("route name is: $routeName");
    switch (routeName) {
      case RouteName.home:
        return MyAppConfiguration.home();
      case RouteName.photoGallery:
        return MyAppConfiguration.photoGallery();
      case RouteName.staff:
        return MyAppConfiguration.staff();
      case RouteName.students:
        return MyAppConfiguration.students();
      case RouteName.videoGallery:
        return MyAppConfiguration.videoGallery();
      case RouteName.contact:
        return MyAppConfiguration.contact();
      default:
        return MyAppConfiguration.unknown();
    }
  }

  // MyAppConfiguration switchSecondPage(String routeName) {
  //   switch (routeName) {
  //     case RouteName.staffDetail:
  //       return MyAppConfiguration.staffDetail(MenuTag.staffDetail);
  //     default:
  //   }
  // }
}
