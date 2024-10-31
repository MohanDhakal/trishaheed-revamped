import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '../model/staff.dart';
import '../utilities/textstyles.dart';
import '../model/blog.dart';
import '../utilities/utilities.dart';
import 'image_gallery.dart';
import 'menupages.dart';
import 'staff_detail.dart' as s;
import 'staff_page.dart';
import 'students.dart';
import 'blogs.dart';

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyAppConfiguration> {
  //to uniquely recognize every page
  late final GlobalKey<NavigatorState> _navigatorKey;
  int? id;
  Blog? blog;
  int? staffId;
  Staff? staff;
  MenuTag _menu = MenuTag.home;
  MenuTag get menu => _menu;
  String _external = ' ';
  String get external => _external;
  bool noticeExists = false;
  int bottomNavigationIndex = 0;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
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
                  menu == MenuTag.blog ||
                  menu == MenuTag.home)
                MaterialPage(
                  child: DefaultTabController(
                    length: MenuIndex.map.length - 3,
                    initialIndex: MenuIndex.map[menu] ?? 0,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: SafeArea(
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 8,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  // HeaderForMobile(
                                  //   onNewNotice: () {
                                  //     noticeExists = true;
                                  //     notifyListeners();
                                  //   },
                                  //   onHome: () {},
                                  //   onResultsPublished: () {
                                  //     // atMenu=MenuTag.unknown;
                                  //     atPath = Result.path;
                                  //   },
                                  // ),
                                  TabBar(
                                    splashBorderRadius: BorderRadius.circular(4),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    automaticIndicatorColorAdjustment: true,
                                    unselectedLabelColor: Colors.grey,
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 4,
                                    ),
                                    indicatorColor: Colors.deepPurple,
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
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              MenuIndex.names.values
                                                  .elementAt(index),
                                              style: CustomTextStyle.menu(context)
                                                  ?.copyWith(
                                                      color: Colors.deepPurple,
                                                      fontSize: 24),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // child: PreferredSize(
                              //   preferredSize: Size.fromHeight(
                              //       30.h),
                              //   child: AppBar(
                              //     backgroundColor: Colors.white,
                              //     elevation: 1,
                              //     flexibleSpace:
                              //     HeaderForMobile(
                              //       onNewNotice: () {
                              //         noticeExists = true;
                              //         notifyListeners();
                              //       },
                              //       onHome: () {},
                              //       onResultsPublished: () {
                              //         // atMenu=MenuTag.unknown;
                              //         atPath = Result.path;
                              //       },
                              //     ),
                              //     automaticallyImplyLeading: false,
                              //     primary: false,
                              //     bottom:
                              //   ),
                              // ),
                            ),
                            Positioned(
                              top: 48,
                              left: 0,
                              bottom: 0,
                              right: 0,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: pages,
                                dragStartBehavior: DragStartBehavior.down,
                              ),
                            ),
                            noticeExists
                                ? Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: InteractiveViewer(
                                        scaleEnabled: true,
                                        constrained: false,
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          color: noticeExists
                                              ? Colors.transparent
                                              : Colors.orange,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("New Notice From School"),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      noticeExists = false;
                                                      notifyListeners();
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_sharp,
                                                      size: 24,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: Image.asset(
                                                  notice,
                                                  fit: BoxFit.fill,
                                                  height: 100,
                                                  // width: size.width * 0.8,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (external == Result.path)
                MaterialPage(
                  child: ViewResult(
                    onBackPressed: () {
                      print('came here');
                      _menu = MenuTag.home;
                      atPath = '';
                    },
                  ),
                ),
              if (menu == MenuTag.unknown) MaterialPage(child: UnknownPage()),
              if (menu == MenuTag.blogDetail)
                MaterialPage(
                  key: ValueKey(RouteName.blogDetail),
                  child: BlogDetail(
                    id: id,
                    onBackPressed: () {
                      atMenu = MenuTag.blog;
                    },
                  ),
                ),
              if (menu == MenuTag.staffDetail && staffId != null)
                MaterialPage(
                  key: ValueKey(RouteName.staffDetail),
                  child: s.StaffDetail(
                    staff: staff,
                    id: staffId,
                    onBackPressed: () {
                      staffId = null;
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

  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async {
    if (configuration.homePage) {
      atMenu = MenuTag.home;
    } else if (configuration.imageGallery) {
      atMenu = MenuTag.photoGallery;
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
    if (external == Result.path) {
      return MyAppConfiguration.result();
    }
    switch (menu) {
      case MenuTag.home:
        return MyAppConfiguration.home();
      case MenuTag.contact:
        return MyAppConfiguration.contact();
      case MenuTag.staff:
        return MyAppConfiguration.staff();
      case MenuTag.blog:
        return MyAppConfiguration.blog();
      case MenuTag.students:
        return MyAppConfiguration.students();
      case MenuTag.extras:
        return MyAppConfiguration.extras();
      case MenuTag.downloads:
        return MyAppConfiguration.downloads();
      case MenuTag.photoGallery:
        return MyAppConfiguration.photoGallery();
      case MenuTag.blogDetail:
        return MyAppConfiguration.blogDetail(id);
      case MenuTag.staffDetail:
        return MyAppConfiguration.staffDetail(staffId);
      default:
        return MyAppConfiguration.unknown();
    }
  }

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

  MyAppRouterDelegate() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void onTabTapped(int index) {
    bottomNavigationIndex = index;
    notifyListeners();
  }

  set atMenu(MenuTag menu) {
    _menu = menu;
    notifyListeners();
  }

  set atPath(String path) {
    print("at path calleed");
    _external = path;
    notifyListeners();
  }
}
