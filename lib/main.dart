import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/pages/blogs.dart';
import 'package:trishaheed/pages/contact_page.dart';
import 'package:trishaheed/pages/downloads_page.dart';
import 'package:trishaheed/pages/home_page.dart';
import 'package:trishaheed/pages/image_gallery.dart';
import 'package:trishaheed/pages/not_found.dart';
import 'package:trishaheed/pages/staff_page.dart';
import 'package:trishaheed/pages/video_gallery.dart';
import 'package:trishaheed/states/menu_state.dart';
import 'package:trishaheed/utilities/menu_map.dart';
import 'package:trishaheed/utilities/menu_tag.dart';
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/my_app_router_information_parser.dart';
import 'package:url_strategy/url_strategy.dart';
import 'model/blog.dart';
import 'pages/blog_detail.dart';
import 'pages/student_detail.dart';
import 'utilities/images.dart';
import 'utilities/textstyles.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MenuState())],
      child: EntryPoint(),
    ),
  );
}

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
  bool _openDrawer = false;
  int? id;
  Blog? blog;
  MyAppRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  MenuTag _menu = MenuTag.home;
  MenuTag get menu => _menu;
  bool noticeExists = false;
  set atMenu(MenuTag menu) {
    _menu = menu;
    notifyListeners();
  }

  set drawer(bool val) {
    _openDrawer = val;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  Widget getPlaceholderPage(MenuTag menu) {
    switch (menu) {
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
      case MenuTag.videoGallery:
        return VideoGallery();
      case MenuTag.extras:
        return UnknownPage(text: "This is Extra Page");
      case MenuTag.downloads:
        return DownloadPage();
      case MenuTag.contact:
        return ContactPage();
      case MenuTag.blog:
        return BlogList(
          onClick: (m, index, post) {
            atMenu = m;
            id = index;
            blog = post;
          },
        );
      default:
        return UnknownPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      HomePage(),
      ImageGallery(),
      TeacherStaff(),
      SizedBox(height: 500, child: StudentDetail()),
      VideoGallery(),
      DownloadPage(),
      UnknownPage(text: "This is an Extra Page"),
      ContactPage(),
      BlogList(
        onClick: ((m, index, post) {
          _menu = m;
          id = index;
          blog = post;
          notifyListeners();
        }),
      ),
    ];
    return ResponsiveWrapper.builder(
      maxWidth: 1700,
      minWidth: 350,
      // defaultScale: true,
      breakpoints: [
        ResponsiveBreakpoint.resize(350, name: MOBILE),
        ResponsiveBreakpoint.autoScale(600, name: TABLET),
        ResponsiveBreakpoint.resize(800, name: DESKTOP),
        ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
      ],
      Consumer<MenuState>(
        builder: (context, state, child) {
          return Navigator(
            key: navigatorKey,
            onPopPage: (route, result) {
              if (!route.didPop(result)) return false;
              if (menu == MenuTag.staff ||
                  menu == MenuTag.photoGallery ||
                  menu == MenuTag.students ||
                  menu == MenuTag.unknown ||
                  menu == MenuTag.extras ||
                  menu == MenuTag.downloads ||
                  menu == MenuTag.contact ||
                  menu == MenuTag.videoGallery ||
                  menu == MenuTag.blog) {
                atMenu = MenuTag.home;
              }
              return true;
            },
            pages: [
              if (menu == MenuTag.staff ||
                  menu == MenuTag.photoGallery ||
                  menu == MenuTag.students ||
                  menu == MenuTag.extras ||
                  menu == MenuTag.downloads ||
                  menu == MenuTag.contact ||
                  menu == MenuTag.videoGallery ||
                  menu == MenuTag.blog ||
                  menu == MenuTag.home)
                MaterialPage(
                  child: DefaultTabController(
                    length: MenuIndex.map.length - 2,
                    initialIndex: MenuIndex.map[menu] ?? 0,
                    child: Scaffold(
                      appBar: size.width <= 800
                          ? AppBar(
                              leading: IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  drawer = !_openDrawer;
                                },
                              ),
                              title: Text("TRI SHAHEED MODEL SECONDARY SCHOOL"),
                            )
                          : PreferredSize(
                              preferredSize: Size.fromHeight(170.0),
                              child: AppBar(
                                flexibleSpace: FixHeader(
                                  onNewNotice: (() {
                                    // print("pressed here");
                                    noticeExists = true;
                                    notifyListeners();
                                  }),
                                ),
                                backgroundColor: Colors.black87,
                                bottom: TabBar(
                                  labelColor: Colors.red,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedLabelStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  onTap: (int value) {
                                    final map = MenuIndex.map;
                                    atMenu = map.keys.firstWhere(
                                        (k) => map[k] == value,
                                        orElse: () => MenuTag.unknown);
                                  },
                                  tabs: List.generate(
                                    MenuIndex.map.length - 2,
                                    (index) {
                                      return Text(
                                        MenuIndex.names.values.elementAt(index),
                                        style: CustomTextStyle.menu(context),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),

                      // drawerDragStartBehavior: DragStartBehavior.start,
                      body: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: size.width < 800
                                ? getPlaceholderPage(menu)
                                : TabBarView(
                                    physics: BouncingScrollPhysics(),
                                    children: pages,
                                  ),
                          ),
                          //If the device is a phone and drawer is open
                          if (size.width <= 800 && _openDrawer == true)
                            SingleChildScrollView(
                              child: Container(
                                color: Color(0xFF077bd7),
                                height: size.width <= 800
                                    ? size.height
                                    : size.width,
                                width: size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      HeaderForMobile(),
                                      ...List<Widget>.generate(
                                        MenuTag.values.length - 2,
                                        (int index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  drawer = false;
                                                  atMenu =
                                                      MenuTag.values[index];
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    MenuIndex.names.values
                                                        .elementAt(index),
                                                    style: CustomTextStyle.menu(
                                                            context)
                                                        ?.copyWith(),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0, bottom: 5.0),
                                                child: Divider(
                                                  color:
                                                      Colors.blueGrey.shade400,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            'Copyright © 2022 | tri-shaheed',
                                            style: TextStyle(
                                              color: Colors.blueGrey.shade300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          noticeExists
                              ? SingleChildScrollView(
                                  child: Center(
                                    child: Container(
                                      height: size.height * 0.9,
                                      width: size.width * 0.8,
                                      color: Colors.red,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("New Notice From School"),
                                              MaterialButton(
                                                onPressed: () {
                                                  noticeExists = false;
                                                  notifyListeners();
                                                },
                                                child: Icon(
                                                  Icons.delete_sweep_sharp,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            potraitSample,
                                            fit: BoxFit.cover,
                                            height: size.height * 0.85,
                                            width: size.width * 0.8,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              if (menu == MenuTag.unknown) MaterialPage(child: UnknownPage()),
              if (menu == MenuTag.blogDetail)
                MaterialPage(
                  // key: ValueKey(RouteName.blogDetail),
                  child: BlogDetail(
                    id: id,
                    blog: blog,
                  ),
                ),
            ],
          );
        },
      ),
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
    } else if (configuration.blog) {
      atMenu = MenuTag.blog;
    } else if (configuration.downloads) {
      atMenu = MenuTag.downloads;
    } else if (configuration.extras) {
      atMenu = MenuTag.extras;
    } else if (configuration.blogDetail) {
      atMenu = MenuTag.blogDetail;
      id = configuration.id;
    } else {
      atMenu = MenuTag.unknown;
    }
  }

  @override
  MyAppConfiguration? get currentConfiguration {
    if (menu == MenuTag.home) {
      return MyAppConfiguration.home();
    } else if (menu == MenuTag.staff) {
      return MyAppConfiguration.staff();
    } else if (menu == MenuTag.videoGallery) {
      return MyAppConfiguration.videoGallery();
    } else if (menu == MenuTag.students) {
      return MyAppConfiguration.students();
    } else if (menu == MenuTag.photoGallery) {
      return MyAppConfiguration.photoGallery();
    } else if (menu == MenuTag.contact) {
      // print("MENU: Reached at contact tag");
      return MyAppConfiguration.contact();
    } else if (menu == MenuTag.downloads) {
      return MyAppConfiguration.downloads();
    } else if (menu == MenuTag.extras) {
      return MyAppConfiguration.extras();
    } else if (menu == MenuTag.blog) {
      return MyAppConfiguration.blog();
    } else if (menu == MenuTag.blogDetail) {
      return MyAppConfiguration.blogDetail(id);
    } else {
      return MyAppConfiguration.unknown();
    }
  }
}

class FixHeader extends StatelessWidget {
  final Function() onNewNotice;
  const FixHeader({
    Key? key,
    required this.onNewNotice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                children: [
                  TextSpan(
                    text: "\nनमुना मा.वि",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 80),
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
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(
                  width: 170,
                ),
              ),
              Image.asset(
                telephone,
                width: 20,
                height: 20,
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(
                  width: 10,
                ),
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
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: TABLET),
                ],
                child: SizedBox(
                  width: 170,
                ),
              ),
              InkWell(
                onTap: onNewNotice,
                child: Container(
                  margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text("नयाँ सूचना"),
                  width: 100,
                  height: 50,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HeaderForMobile extends StatelessWidget {
  const HeaderForMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  logo,
                  width: 100,
                  height: 100,
                ),
              ),
              Text.rich(
                TextSpan(
                  text: "श्री त्रि-शहिद",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  children: [
                    TextSpan(
                      text: "\nनमुना मा.वि",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Image.asset(
                paperPlane,
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
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
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 10),
              Image.asset(
                telephone,
                width: 20,
                height: 20,
              ),
              SizedBox(width: 10),
              Text(
                "Call: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "9846095574",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 5, top: 5, right: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
            child: Text("नयाँ सूचना"),
          ),
        ],
      ),
    );
  }
}
