import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trishaheed/pages/home_page.dart';
import 'package:trishaheed/pages/image_gallery.dart';
import 'package:trishaheed/pages/not_found.dart';
import 'package:trishaheed/pages/staff_page.dart';
import 'package:trishaheed/utilities/menu_tag.dart';
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/my_app_router_information_parser.dart';
import 'package:url_strategy/url_strategy.dart';
import 'pages/student_detail.dart';
import 'utilities/images.dart';
import 'utilities/textstyles.dart';
import 'widgets/header.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(EntryPoint());
}

// class WidgetTestClass extends StatelessWidget {
//   const WidgetTestClass({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StudentDetail(),
//     );
//   }
// }

class EntryPoint extends StatelessWidget {
  final delegate = MyAppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: ThemeData(fontFamily: 'OpenSans'),
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: MyAppRouterInformationParser(),
      routerDelegate: delegate,
    );
  }
}

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  //to uniquely recognize every page

  late final GlobalKey<NavigatorState> _navigatorKey;
  MyAppRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  MenuTag? _menu;
  MenuTag? get menu => _menu;

  set atMenu(MenuTag? menu) {
    _menu = menu;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(176),
              child: AppBar(
                flexibleSpace: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                logo,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "श्री त्रि-शहिद",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "\nनमुना मा.वि",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  paperPlane,
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Email: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "trishaheed1986@gmail.com",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 170,
                                ),
                                Image.asset(
                                  telephone,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Call: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "9846095574",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("नयाँ सूचना"),
                                  width: 100,
                                  height: 50,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black87,
                        height: 56,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                            MenuTag.values.length,
                            (index) {
                              if (MenuTag.values[index].name ==
                                  MenuTag.unknown) {
                                // print("came here");
                                return SizedBox();
                              }

                              return InkWell(
                                onTap: () {
                                  atMenu = MenuTag.values[index];
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(
                                    MenuTag.values[index].name,
                                    style: CustomTextStyle.menu(context)
                                        ?.copyWith(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: PagePlaceholder(menuTag: menu),
          ),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (menu == MenuTag.staff ||
            menu == MenuTag.photoGallery ||
            menu == MenuTag.students ||
            menu == MenuTag.unknown ||
            menu == MenuTag.extras ||
            menu == MenuTag.routine ||
            menu == MenuTag.results ||
            menu == MenuTag.contact ||
            menu == MenuTag.videoGallery) {
          atMenu = MenuTag.home;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.homePage) {
      atMenu = MenuTag.home;
    } else if (configuration.imageGallery) {
      atMenu = MenuTag.photoGallery;
    } else if (configuration.videoGallery) {
      atMenu = MenuTag.videoGallery;
    } else if (configuration.students) {
      atMenu = MenuTag.students;
    } else if (configuration.contact) {
      atMenu = MenuTag.contact;
    } else if (configuration.staffPage) {
      atMenu = MenuTag.staff;
    } else if (configuration.extras) {
      atMenu = MenuTag.extras;
    } else if (configuration.routine) {
      atMenu = MenuTag.routine;
    } else if (configuration.results) {
      atMenu = MenuTag.results;
    } else {
      atMenu = null;
    }
  }

  @override
  MyAppConfiguration? get currentConfiguration {
    if (menu == MenuTag.home) {
      return MyAppConfiguration.home(MenuTag.home);
    } else if (menu == MenuTag.staff) {
      return MyAppConfiguration.staff(MenuTag.staff);
    } else if (menu == MenuTag.videoGallery) {
      return MyAppConfiguration.videoGallery(MenuTag.videoGallery);
    } else if (menu == MenuTag.students) {
      return MyAppConfiguration.students(MenuTag.students);
    } else if (menu == MenuTag.photoGallery) {
      return MyAppConfiguration.photoGallery(MenuTag.photoGallery);
    } else if (menu == MenuTag.contact) {
      return MyAppConfiguration.contact(MenuTag.contact);
    } else if (menu == MenuTag.results) {
      return MyAppConfiguration.results(MenuTag.results);
    } else if (menu == MenuTag.routine) {
      return MyAppConfiguration.routine(MenuTag.routine);
    } else {
      return MyAppConfiguration.unknown();
    }
  }
}

class PagePlaceholder extends StatelessWidget {
  final MenuTag? menuTag;
  const PagePlaceholder({Key? key, required this.menuTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (menuTag) {
      case MenuTag.home:
        return HomePage();
      case MenuTag.staff:
        return TeacherStaff();
      case MenuTag.photoGallery:
        return ImageGallery();
      case MenuTag.students:
        return SizedBox(
          height: 500,
          child: StudentDetail(),
        );
      case MenuTag.extras:
        return UnknownPage(
          text: "This is an Extra Page",
        );
      case MenuTag.results:
        return UnknownPage(text: "This should be results page");
      case MenuTag.routine:
        return UnknownPage(text: "This should be routine page");
      case MenuTag.videoGallery:
        return UnknownPage(text: "This should be Video Gallery");
      case MenuTag.contact:
        return UnknownPage(text: "This should be Contact Page");
      default:
        return UnknownPage();
    }
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(176),
        super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Header(),
    );
  }
}
