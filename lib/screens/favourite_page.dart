import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/components/searched_movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_states.dart';
import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/home_page.dart';
// import 'package:movies_app/screens/home_page.dart';
// import 'package:movies_app/screens/home_page_body.dart';
// import 'package:movies_app/services/favourite_services.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key, required this.isInProfile});
  final bool isInProfile;

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool isSorted = true;

  @override
  initState() {
    BlocProvider.of<FavCubit>(context).fetchAllFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: kPrimaryColor,
      //   surfaceTintColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   title: Container(
      //     decoration: BoxDecoration(color: Colors.red),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         widget.isInProfile == true
      //             ? GestureDetector(
      //                 onTap: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.all(0.8),
      //                   decoration: BoxDecoration(
      //                     // color: Colors.white.withAlpha(25),
      //                     gradient: LinearGradient(
      //                       colors: [
      //                         Colors.white.withAlpha(50),
      //                         // Colors.white.withAlpha(20),
      //                         Colors.white.withAlpha(10),
      //                       ],
      //                       begin: AlignmentGeometry.topCenter,
      //                       end: AlignmentGeometry.bottomCenter,
      //                     ),
      //                     borderRadius: BorderRadius.circular(50),
      //                     border: Border(
      //                       top: BorderSide(
      //                         color: Colors.grey.shade100.withAlpha(50),
      //                         width: 0.4,
      //                       ),
      //                     ),
      //                   ),
      //                   child: Icon(
      //                     Icons.chevron_left_rounded,
      //                     size: 32,
      //                     color: kTextColor,
      //                   ),
      //                 ),
      //               )
      //             : SizedBox.shrink(),
      //         widget.isInProfile
      //             ? const SizedBox(width: 14)
      //             : SizedBox.shrink(),
      //         Text(
      //           'Favourites',
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //             color: kTextColor,
      //           ),
      //         ),
      //         Spacer(),
      //         GestureDetector(
      //           onTap: () {
      //             setState(() {
      //               isSorted = !isSorted;
      //             });
      //           },
      //           child: Container(
      //             padding: EdgeInsets.all(6),
      //             decoration: BoxDecoration(
      //               // color: Colors.white70.withAlpha(25),
      //               gradient: LinearGradient(
      //                 colors: [
      //                   Colors.white.withAlpha(50),
      //                   // Colors.white.withAlpha(20),
      //                   Colors.white.withAlpha(10),
      //                 ],
      //                 begin: AlignmentGeometry.topCenter,
      //                 end: AlignmentGeometry.bottomCenter,
      //               ),
      //               borderRadius: BorderRadius.circular(50),
      //               border: Border(
      //                 top: BorderSide(
      //                   color: Colors.grey.shade100.withAlpha(50),
      //                   width: 0.4,
      //                 ),
      //                 // right: BorderSide(
      //                 //   color: Colors.grey.shade100.withAlpha(50),
      //                 //   width: 0.3,
      //                 // ),
      //                 // left: BorderSide(
      //                 //   color: Colors.grey.shade100.withAlpha(20),
      //                 //   width: 0.3,
      //                 // ),
      //               ),
      //             ),
      //             child: Icon(
      //               Icons.swap_vert_rounded,
      //               size: 22,
      //               color: kTextColor,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 8,
                bottom: 0,
              ),
              child: BlocBuilder<FavCubit, FavState>(
                builder: (context, state) {
                  List<MovieModel> favourites = BlocProvider.of<FavCubit>(
                    context,
                  ).movies;
                  List<MovieModel> reversedFavourites = favourites.reversed
                      .toList();

                  return favourites.isEmpty
                      ? Center(
                          child: Text(
                            'No Favourites yet!',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: favourites.length,
                                itemBuilder: (context, index) {
                                  MovieModel movie = isSorted
                                      ? favourites[index]
                                      : reversedFavourites[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: SearchedMovieItem(movie: movie),
                                  );
                                },
                              ),
                              SizedBox(height: 70),
                            ],
                          ),
                        );
                },
              ),
            ),

            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.red
                  gradient: LinearGradient(
                    colors: [
                      kPrimaryColor,
                      kPrimaryColor.withAlpha(250),
                      kPrimaryColor.withAlpha(240),
                      // kPrimaryColor.withAlpha(230),
                      // kPrimaryColor.withAlpha(220),
                      // kPrimaryColor.withAlpha(200),
                      kPrimaryColor.withAlpha(200),
                      kPrimaryColor.withAlpha(100),
                      kPrimaryColor.withAlpha(5),
                    ],
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.only(
                  right: 12,
                  left: 12,
                  top: 12,
                  bottom: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.isInProfile == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(0.8),
                              decoration: BoxDecoration(
                                // color: Colors.white.withAlpha(25),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withAlpha(50),
                                    // Colors.white.withAlpha(20),
                                    Colors.white.withAlpha(10),
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey.shade100.withAlpha(50),
                                    width: 0.4,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                size: 32,
                                color: kTextColor,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    widget.isInProfile ? Spacer() : SizedBox.shrink(),
                    Text(
                      'Favourites',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSorted = !isSorted;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          // color: Colors.white70.withAlpha(25),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withAlpha(50),
                              // Colors.white.withAlpha(20),
                              Colors.white.withAlpha(10),
                            ],
                            begin: AlignmentGeometry.topCenter,
                            end: AlignmentGeometry.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.shade100.withAlpha(50),
                              width: 0.4,
                            ),
                            // right: BorderSide(
                            //   color: Colors.grey.shade100.withAlpha(50),
                            //   width: 0.3,
                            // ),
                            // left: BorderSide(
                            //   color: Colors.grey.shade100.withAlpha(20),
                            //   width: 0.3,
                            // ),
                          ),
                        ),
                        child: Icon(
                          Icons.swap_vert_rounded,
                          size: 22,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
