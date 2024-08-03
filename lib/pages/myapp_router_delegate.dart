import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:trishaheed/model/staff.dart';
import 'package:trishaheed/pages/results_page.dart';
import 'package:trishaheed/pages/staff_detail.dart' as s;
import 'package:trishaheed/utilities/my_app_config.dart';
import 'package:trishaheed/utilities/results.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../model/blog.dart';
import '../states/menu_state.dart';
import '../utilities/globals.dart';
import '../utilities/images.dart';
import '../utilities/menu_map.dart';
import '../utilities/menu_tag.dart';
import '../utilities/route_names.dart';
import '../utilities/textstyles.dart';
import 'blog_detail.dart';
import 'blogs.dart';
import 'contact_page.dart';
import 'downloads_page.dart';
import 'extras_page.dart';
import 'headers.dart';
import 'home_page.dart';
import 'image_gallery_test.dart';
import 'not_found.dart';
import 'staff_page.dart';
import 'students.dart';

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  //to uniquely recognize every page
  late final GlobalKey<NavigatorState> _navigatorKey;
  bool _openDrawer = false;
  int? id;
  Blog? blog;
  int? staffId;
  Staff? staff;
  MyAppRouterDelegate() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }
  MenuTag _menu = MenuTag.home;
  MenuTag get menu => _menu;
  String _external = ' ';
  String get external => _external;
  bool noticeExists = false;

  set atMenu(MenuTag menu) {
    _menu = menu;
    notifyListeners();
  }

  set atPath(String path) {
    _external = path;
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
          onClick: (m, teacherModel, id) {
            staff = teacherModel;
            staffId = id;
            atMenu = m;
          },
        );
      case MenuTag.photoGallery:
        return ImageGallery();
      case MenuTag.students:
        return Students();
      // case MenuTag.videoGallery:
      //   return VideoGallery();
      case MenuTag.extras:
        return ExtrasPage();
      case MenuTag.downloads:
        return DownloadPage();
      case MenuTag.contact:
        return ContactPage();
      case MenuTag.blog:
        return BlogList(
          onClick: (m, index, post) {
            id = index;
            blog = post;
            atMenu = m;
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
        onClick: (m, teacherModel, id) {
          staff = teacherModel;
          staffId = id;
          atMenu = m;
        },
      ),
      Students(),
      // VideoGallery(),
      DownloadPage(),
      ExtrasPage(),
      ContactPage(),
      BlogList(
        onClick: ((m, index, post) {
          id = index;
          blog = post;
          atMenu = m;
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
                  // menu == MenuTag.videoGallery ||
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
                  // menu == MenuTag.videoGallery ||
                  menu == MenuTag.blog ||
                  menu == MenuTag.home)
                MaterialPage(
                  child: DefaultTabController(
                    length: MenuIndex.map.length - 3,
                    initialIndex: MenuIndex.map[menu] ?? 0,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      primary: false,
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
                              preferredSize: Size.fromHeight(140.0),
                              child: AppBar(
                                backgroundColor: Colors.black,
                                elevation: 1,
                                flexibleSpace: FixHeader(
                                  onHome: () {
                                    atMenu = MenuTag.home;
                                    Future.delayed(Duration(milliseconds: 200))
                                        .then((value) {
                                      html.window.location.reload();
                                    });
                                  },
                                  onNewNotice: (() {
                                    noticeExists = true;
                                    notifyListeners();
                                  }),
                                  onResultsPublished: () {
                                    _launchURL(Globals.resultSystem);
                                  },
                                ),
                                automaticallyImplyLeading: false,
                                primary: false,
                                bottom: TabBar(
                                  splashBorderRadius: BorderRadius.circular(4),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  automaticIndicatorColorAdjustment: false,
                                  unselectedLabelColor: Colors.grey,
                                  labelPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  indicator: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      width: 8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: (int value) {
                                    final map = MenuIndex.map;
                                    atMenu = map.keys.firstWhere(
                                      (k) => map[k] == value,
                                      orElse: () => MenuTag.unknown,
                                    );
                                  },
                                  tabs: List.generate(
                                    MenuIndex.map.length - 3,
                                    (index) {
                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          MenuIndex.names.values
                                              .elementAt(index),
                                          style: CustomTextStyle.menu(context),
                                        ),
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
                                      onHome: () {
                                        atMenu = MenuTag.home;
                                        Future.delayed(
                                                Duration(milliseconds: 200))
                                            .then((value) {
                                          html.window.location.reload();
                                        });
                                      },
                                      onResultsPublished: () {
                                        _launchURL(Globals.resultSystem);
                                      },
                                      onNewNotice: (() {
                                        noticeExists = true;
                                        notifyListeners();
                                      }),
                                    ),
                                    ...List<Widget>.generate(
                                      MenuTag.values.length - 3,
                                      (int index) {
                                        return Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: [
                                            GestureDetector(
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
                                              MainAxisAlignment.spaceAround,
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
              if (external == Result.path) MaterialPage(child: ViewResult()),
              if (menu == MenuTag.unknown) MaterialPage(child: UnknownPage()),
              if (menu == MenuTag.blogDetail)
                MaterialPage(
                  key: ValueKey(RouteName.blogDetail),
                  child: BlogDetail(id: id),
                ),
              if (menu == MenuTag.staffDetail && staffId != null)
                MaterialPage(
                  key: ValueKey(RouteName.staffDetail),
                  child: s.StaffDetail(
                    staff: staff,
                    id: staffId,
                    onBackPressed: () {
                      staffId=null;
                      atMenu = MenuTag.staff;
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.homePage) {
      atMenu = MenuTag.home;
    } else if (configuration.imageGallery) {
      atMenu = MenuTag.photoGallery;
    }
    // else if (configuration.videoGallery) {
    //   atMenu = MenuTag.videoGallery;
    // }
    else if (configuration.students) {
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
      id = configuration.id;
      atMenu = MenuTag.blogDetail;
    } else if (configuration.staffDetail) {
      staffId = configuration.staffId;
      atMenu = MenuTag.staffDetail;
    } else if (configuration.result) {
      atPath = Result.path;
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
    }
    //  else if (menu == MenuTag.videoGallery) {
    //   return MyAppConfiguration.videoGallery();
    // }
    else if (menu == MenuTag.students) {
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
    } else if (menu == MenuTag.staffDetail) {
      return MyAppConfiguration.staffDetail(staffId);
    } else if (external == Result.path) {
      return MyAppConfiguration.result();
    } else {
      return MyAppConfiguration.unknown();
    }
  }
}
