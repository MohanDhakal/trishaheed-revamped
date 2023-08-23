import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/model/gallery_state.dart';
import 'package:trishaheed/model/states/dowloads_state.dart';
import 'package:trishaheed/model/states/staff_state.dart';
import 'package:trishaheed/model/states/students_state.dart';
import 'package:trishaheed/pages/blogs.dart';
import 'package:trishaheed/pages/contact_page.dart';
import 'package:trishaheed/pages/downloads_page.dart';
import 'package:trishaheed/pages/home_page.dart';
import 'package:trishaheed/pages/not_found.dart';
import 'package:trishaheed/pages/staff_page.dart';
import 'package:trishaheed/pages/students.dart';
import 'package:trishaheed/pages/video_gallery.dart';
import 'package:trishaheed/states/menu_state.dart';
import 'package:trishaheed/utilities/menu_map.dart';
import 'package:trishaheed/utilities/menu_tag.dart';
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/my_app_router_information_parser.dart';
import 'package:url_strategy/url_strategy.dart';
import 'model/blog.dart';
import 'pages/blog_detail.dart';
import 'pages/image_gallery_test.dart';
import 'utilities/images.dart';
import 'utilities/textstyles.dart';

void main(List<String> args) {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuState()),
        ChangeNotifierProvider(create: (_) => StudentState()),
        ChangeNotifierProvider(create: (_) => GalleryState()),
        ChangeNotifierProvider(create: (_) => StaffState()),
        ChangeNotifierProvider(create: (_) => DownloadState()),
      ],
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
      title: "STSSS",
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      // theme: ThemeData(fontFamily: 'OpenSans'),
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
  // ignore: unused_field
  TeacherStaff? _teacherStaff;
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
        return TeacherStaff(
          onClick: (teacherModel) {
            _teacherStaff = teacherModel;
          },
        );
      case MenuTag.photoGallery:
        return ImageGallery();
      case MenuTag.students:
        return Students();
      case MenuTag.videoGallery:
        return VideoGallery();
      case MenuTag.extras:
        return UnknownPage(text: "This page is under developement");
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
      TeacherStaff(
        onClick: (teacherModel) {
          _teacherStaff = teacherModel;
          notifyListeners();
        },
      ),
      Students(),
      VideoGallery(),
      DownloadPage(),
      UnknownPage(text: "This page is under developement"),
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
                      appBar: ResponsiveWrapper.of(context)
                              .isSmallerThan(DESKTOP)
                          ? AppBar(
                              backgroundColor: Colors.black87,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  size: 24,
                                  color: Colors.white60,
                                ),
                                onPressed: () {
                                  drawer = !_openDrawer;
                                },
                              ),
                              title: SelectableText(
                                "TRI SHAHEED MODEL SECONDARY SCHOOL",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                ),
                              ),
                            )
                          : PreferredSize(
                              preferredSize: Size.fromHeight(160.0),
                              child: AppBar(
                                flexibleSpace: FixHeader(
                                  onNewNotice: (() {
                                    noticeExists = true;
                                    notifyListeners();
                                  }),
                                ),
                                backgroundColor: Colors.black87,
                                bottom: TabBar(
                                  labelColor: Colors.red,
                                  unselectedLabelColor: Colors.grey,
                                  splashBorderRadius: BorderRadius.circular(4),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      width: 8,
                                      color: Colors.blue,
                                    ),
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
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            child: ResponsiveWrapper.of(context)
                                    .isSmallerThan(DESKTOP)
                                ? getPlaceholderPage(menu)
                                : TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: pages,
                                  ),
                          ),
                          //If the device is a phone and drawer is open
                          if (ResponsiveWrapper.of(context)
                                  .isSmallerThan(DESKTOP) &&
                              _openDrawer == true)
                            SingleChildScrollView(
                              child: Container(
                                color: Colors.black,
                                height: size.height,
                                width: size.width,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    HeaderForMobile(
                                      onNewNotice: (() {
                                        noticeExists = true;
                                        notifyListeners();
                                      }),
                                    ),
                                    ...List<Widget>.generate(
                                      MenuTag.values.length - 2,
                                      (int index) {
                                        return Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                drawer = false;
                                                atMenu = MenuTag.values[index];
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  left: 4.0,
                                                ),
                                                height: 24,
                                                child: Text(
                                                  MenuIndex.names.values
                                                      .elementAt(index),
                                                  style: CustomTextStyle.menu(
                                                          context)
                                                      ?.copyWith(),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.blueGrey.shade400,
                                              thickness: 2,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Copyright © 2022 | tri-shaheed',
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade300,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          noticeExists
                              ? InteractiveViewer(
                                  scaleEnabled: true,
                                  constrained: false,
                                  alignment: Alignment.center,
                                  child: AnimatedContainer(
                                    height: size.height * 0.95,
                                    width: size.width,
                                    color: noticeExists
                                        ? Colors.white
                                        : Colors.orange,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    duration: Duration(milliseconds: 500),
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
                                                Icons.cancel_sharp,
                                                size: 36,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          notice,
                                          fit: BoxFit.cover,
                                          height: size.height * 0.85,
                                          // width: size.width * 0.8,
                                        )
                                      ],
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
                  child: BlogDetail(id: id),
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
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                children: [
                  TextSpan(
                    text: "\nनमुना मा.वि",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
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
              SelectableText(
                "Email: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SelectableText(
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
              SelectableText(
                "Call: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SelectableText(
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
                  child: Text("New Notice"),
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
  final Function() onNewNotice;
  const HeaderForMobile({Key? key, required this.onNewNotice})
      : super(key: key);

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        telephone,
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      SelectableText(
                        "Call: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      SelectableText(
                        "9846095574",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        paperPlane,
                        width: 24,
                        height: 24,
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
                  MaterialButton(
                    onPressed: onNewNotice,
                    child: Container(
                      height: 50,
                      width: size.width * 0.5,
                      margin: EdgeInsets.only(
                          left: 10, bottom: 5, top: 5, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      alignment: Alignment.center,
                      child: Text("New Notice"),
                    ),
                  ),
                ],
              ),

              // Text.rich(
              //   TextSpan(
              //     text: "श्री त्रि-शहिद",
              //     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //     children: [
              //       TextSpan(
              //         text: "\nनमुना मा.वि",
              //         style: Theme.of(context)
              //             .textTheme
              //             .headlineSmall
              //             ?.copyWith(fontWeight: FontWeight.bold),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
