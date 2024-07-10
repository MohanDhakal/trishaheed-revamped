import 'package:flutter/cupertino.dart';
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/route_names.dart';

class MyAppRouterInformationParser
    extends RouteInformationParser<MyAppConfiguration> {
  @override
  RouteInformation? restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.homePage) {
      return RouteInformation(uri: Uri.parse(RouteName.home));
    } else if (configuration.staffPage) {
      return RouteInformation(uri: Uri.parse(RouteName.staff));
    } else if (configuration.students) {
      return RouteInformation(uri: Uri.parse(RouteName.students));
    } else if (configuration.imageGallery) {
      return RouteInformation(uri: Uri.parse(RouteName.photoGallery));
    }
    //  else if (configuration.videoGallery) {
    //   return RouteInformation(location: RouteName.videoGallery);
    // }
    else if (configuration.extras) {
      return RouteInformation(uri: Uri.parse(RouteName.extras));
    } else if (configuration.blog) {
      return RouteInformation(uri: Uri.parse(RouteName.blog));
    } else if (configuration.contact) {
      return RouteInformation(uri: Uri.parse(RouteName.contact));
    } else if (configuration.downloads) {
      return RouteInformation(uri: Uri.parse(RouteName.downloads));
    } else if (configuration.blogDetail) {
      return RouteInformation(
          uri: Uri.parse(RouteName.blogDetail + "${configuration.id}"));
    } else if (configuration.staffDetail) {
      return RouteInformation(
          uri: Uri.parse(RouteName.staffDetail + "${configuration.staffId}"));
    } else if (configuration.result) {
      return RouteInformation(uri: Uri.parse(RouteName.result));
    } else {
      return RouteInformation(uri: Uri.parse(RouteName.unknown));
    }
  }

  @override
  Future<MyAppConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.path);
    final first = uri.pathSegments[0].toLowerCase();
    if (uri.pathSegments.length == 0) {
     
      return MyAppConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      return switchFirstPage("/" + first);
    } else if (uri.pathSegments.length == 3) {
      final second = uri.pathSegments[1].toLowerCase();
      final staffId = int.tryParse(uri.pathSegments[2]);
      final id = int.tryParse(uri.pathSegments[2]);
      final pathToCheck = "/" + first + "/" + second + "/";
      if (pathToCheck == RouteName.staffDetail) {
        if (staffId == null)
          return MyAppConfiguration.unknown();
        else
          return MyAppConfiguration.staffDetail(staffId);
      } else if (pathToCheck == RouteName.blogDetail) {
        if (id == null)
          return MyAppConfiguration.unknown();
        else
          return MyAppConfiguration.blogDetail(id);
      } else
        return MyAppConfiguration.unknown();
    } else
      return MyAppConfiguration.unknown();
  }

  MyAppConfiguration switchFirstPage(String routeName) {
    switch (routeName) {
      case RouteName.home:
        return MyAppConfiguration.home();
      case RouteName.photoGallery:
        return MyAppConfiguration.photoGallery();
      case RouteName.staff:
        return MyAppConfiguration.staff();
      case RouteName.students:
        return MyAppConfiguration.students();
      // case RouteName.videoGallery:
      //   return MyAppConfiguration.videoGallery();
      case RouteName.contact:
        return MyAppConfiguration.contact();
      case RouteName.extras:
        return MyAppConfiguration.extras();
      case RouteName.blog:
        return MyAppConfiguration.blog();
      case RouteName.downloads:
        return MyAppConfiguration.downloads();
      case RouteName.result:
        return MyAppConfiguration.result();
      default:
        return MyAppConfiguration.unknown();
    }
  }

  // MyAppConfiguration switchSecondPage(String routeName) {
  //   switch (routeName) {
  //     case RouteName.blogDetail:
  //       return MyAppConfiguration.blogDetail();
  //     default:
  //   }
  // }
}
