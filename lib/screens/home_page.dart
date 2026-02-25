import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/screens/discover_screen.dart';
import 'package:movies_app/screens/favourite_page.dart';
import 'package:movies_app/screens/home_page_body.dart';
import 'package:movies_app/screens/profile_screen.dart';
// import 'package:movies_app/screens/search_page.dart';
// import 'package:movies_app/components/movie_item.dart';
// import 'package:movies_app/constant.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/favourite_page.dart';
// import 'package:movies_app/screens/home_page_body.dart';
// import 'package:movies_app/screens/movie_details_page.dart';
// import 'package:movies_app/screens/search_page.dart';
// import 'package:movies_app/services/movies_sevices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePageBody(),
    // SearchPage(),
    DiscoverScreen(),
    FavouritePage(isInProfile: false),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          pages[currentIndex],

          Positioned(
            // top: 100,
            bottom: 0,
            left: 0,
            right: 0,
            // height: 55,
            height: 63,
            child: Container(
              decoration: BoxDecoration(
                
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    // Colors.red,
                    // Colors.black,
                    kPrimaryColor,
                    kPrimaryColor.withAlpha(30),
                    // kPrimaryColor,
                    // Colors.transparent,
                    // Colors.white.withAlpha(0),
                    // Colors.transparent,

                    // Colors.yellow
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            // height: 100,
            //  bottom: 0,  // => emulator
            bottom: 8, // => windows
            left: 6,
            right: 6,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: NavigationBar(
                    labelPadding: const EdgeInsets.all(0),
                    // height: 63, // emulator
                    height: 56, // => windows
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    animationDuration: Duration(milliseconds: 400),
                    // indicatorColor: Colors.white.withAlpha(23),
                    indicatorColor: const Color.fromARGB(255, 32, 42, 56),
                    backgroundColor: const Color.fromARGB(255, 36, 52, 73),
                    onDestinationSelected: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    selectedIndex: currentIndex,
                    destinations: [
                      NavigationDestination(
                        // icon: Icon(Icons.home_outlined , ),
                        icon: SvgPicture.asset(
                          'assets/Home.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        selectedIcon: SvgPicture.asset(
                          'assets/home_selected.svg',
                          colorFilter: ColorFilter.mode(
                            kIconsColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/Search.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        selectedIcon: SvgPicture.asset(
                          'assets/Search.svg',
                          colorFilter: ColorFilter.mode(
                            kIconsColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Search',
                      ),
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/Bookmark.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        selectedIcon: SvgPicture.asset(
                          'assets/Bookmark.svg',
                          colorFilter: ColorFilter.mode(
                            kIconsColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Favourites',
                      ),
                      NavigationDestination(
                        icon: SvgPicture.asset(
                          'assets/Profile.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        selectedIcon: SvgPicture.asset(
                          'assets/Profile_selected.svg',
                          colorFilter: ColorFilter.mode(
                            kIconsColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // bottomNavigationBar:
      //  Padding(
      //   padding: const EdgeInsets.all(6),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(32),
      //     child: NavigationBar(
      //       height: 56,
      //       labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      //       animationDuration: Duration(milliseconds: 400),
      //       // indicatorColor: Colors.white.withAlpha(23),
      //       indicatorColor: const Color.fromARGB(255, 32, 42, 56),

      //       backgroundColor: const Color.fromARGB(255, 36, 52, 73),
      //       onDestinationSelected: (index) {
      //         setState(() {
      //           currentIndex = index;
      //         });
      //       },
      //       selectedIndex: currentIndex,
      //       destinations: [
      //         NavigationDestination(

      //           // icon: Icon(Icons.home_outlined , ),
      //           icon: SvgPicture.asset('assets/Home.svg' , colorFilter:ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      //           selectedIcon: SvgPicture.asset('assets/home_selected.svg', colorFilter:ColorFilter.mode(kIconsColor, BlendMode.srcIn),),
      //           label: 'Home',
      //         ),
      //         NavigationDestination(
      //           icon: SvgPicture.asset('assets/Search.svg' , colorFilter:ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      //         selectedIcon: SvgPicture.asset('assets/Search.svg' , colorFilter:ColorFilter.mode(kIconsColor, BlendMode.srcIn),),
      //          label: 'Search'),
      //         NavigationDestination(
      //           icon: SvgPicture.asset('assets/Bookmark.svg' , colorFilter:ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      //           selectedIcon:
      //            SvgPicture.asset('assets/Bookmark.svg' , colorFilter:ColorFilter.mode(kIconsColor, BlendMode.srcIn),),
      //           label: 'Favourites',
      //         ),
      //         NavigationDestination(
      //           icon: SvgPicture.asset('assets/Profile.svg' , colorFilter:ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      //         selectedIcon: SvgPicture.asset('assets/Profile_selected.svg' , colorFilter:ColorFilter.mode(kIconsColor, BlendMode.srcIn),),
      //          label: 'Profile'),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
