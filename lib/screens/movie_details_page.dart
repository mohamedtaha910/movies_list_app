// screen 1 :
// every single element in the row in stack

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movies_app/components/cast_view.dart';
// import 'package:movies_app/components/details_row.dart';
// import 'package:movies_app/components/horizintal_line.dart';
// import 'package:movies_app/components/movie_item.dart';
// import 'package:movies_app/components/similiar_movies_view.dart';
// import 'package:movies_app/components/trailer_button.dart';
// import 'package:movies_app/constant.dart';
// import 'package:movies_app/cubits/add_favourite_cubit/add_favourite_cubit.dart';
// import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
// import 'package:movies_app/models/movie_details_model.dart';
// import 'package:movies_app/services/favourite_services.dart';
// import 'package:movies_app/services/movies_sevices.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MovieDetails extends StatefulWidget {
//   const MovieDetails({super.key, required this.id});
//   final int id;

//   @override
//   State<MovieDetails> createState() => _MovieDetailsState();
// }

// class _MovieDetailsState extends State<MovieDetails> {
//   String? trailerKey = '';
//   bool isLoadingTrailer = true;

//   late MovieDetailsModel movie;

//   @override
//   void initState() {
//     super.initState();
//     fetchTrailer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Color favColor = Colors.white;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         surfaceTintColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back_ios_new),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             Text(
//               'Details',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   BlocProvider.of<AddFavCubit>(
//                     context,
//                   ).addFavourite(movie.toMovieModel());
//                   BlocProvider.of<FavCubit>(context).fetchAllFav();
//                 });
//               },
//               icon: FavouritesService().isFavourite(widget.id)
//                   ? Icon(Icons.bookmark, color: kIconsColor, size: 28)
//                   : Icon(Icons.bookmark_border, color: Colors.white, size: 28),
//             ),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: FutureBuilder(
//           future: MoviesServices().getMovieDetails(widget.id),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               movie = snapshot.data!;
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           movie.backdropPath.isEmpty
//                               ? Image.asset('assets/backdrop.png')
//                               : ClipRRect(
//                                   borderRadius: BorderRadiusGeometry.circular(
//                                     6,
//                                   ),
//                                   child: Image.network(
//                                     'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
//                                   ),
//                                 ),

//                           // shadow
//                           Positioned(
//                             // top: 100,
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             height: 70,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.center,
//                                   colors: [
//                                     // Colors.red,
//                                     // Colors.black,
//                                     kPrimaryColor,
//                                     // kPrimaryColor.withAlpha(200),
//                                     // kPrimaryColor,
//                                     Colors.transparent,
//                                     // Colors.transparent,

//                                     // Colors.yellow
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),

//                           // rating on the top
//                           Container(
//                             margin: const EdgeInsets.all(8),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 3,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.black.withAlpha(100),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.star_border_sharp,
//                                   size: 18,
//                                   color: Colors.orangeAccent,
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   movie.voteAverage.toString().substring(0, 3),
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     // color: kTextColor,
//                                     color: Colors.orangeAccent,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // poster
//                           Positioned(
//                             top: 192,
//                             // bottom: 0,
//                             right: 10,
//                             child: MovieItem(
//                               movieImage: movie.posterPath,
//                               height: 175,
//                               width: 115,
//                             ),
//                           ),

//                           // title
//                           Positioned(
//                             top: 215,
//                             // bottom: 0,
//                             left: 10,
//                             child: Text(
//                               movie.title,
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),

//                           // rating
//                           Positioned(
//                             top: 270,
//                             // bottom: 0,
//                             left: 10,
//                             child: Container(
//                               // margin: const EdgeInsets.all(8),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 3,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.white.withAlpha(25),
//                                 // color: kTextColor.withAlpha(60),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Icon(
//                                     Icons.star_border_sharp,
//                                     size: 18,
//                                     color: Colors.orangeAccent,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     movie.voteAverage.toString().substring(
//                                       0,
//                                       3,
//                                     ),
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       // color: kTextColor,
//                                       color: Colors.orangeAccent,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // trailer
//                           Positioned(
//                             top: 310,
//                             // bottom: 0,
//                             left: 10,
//                             child: TrailerButton(
//                               movieId: movie.id,
//                               onTap: () {
//                                 trailerKey!.isEmpty
//                                     ? showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return Center(
//                                             child: Text(
//                                               'No trailer available !',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: kTextColor,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       )
//                                     : openTrailer();
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 160),

//                       // const Spacer(),

//                       // Spacer(),
//                       // SizedBox(height: 16),
//                       HorizintalLine(),

//                       DetailsRow(movie: movie),

//                       HorizintalLine(),

//                       SizedBox(height: 18),

//                       /// about movie :
//                       Text(
//                         'About Movie ',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Text(
//                         movie.overview.isEmpty ? 'No overview' : movie.overview,
//                         style: TextStyle(fontSize: 16, color: kTextColor),
//                       ),
//                       SizedBox(height: 18),
//                       HorizintalLine(),
//                       SizedBox(height: 18),

//                       /// cast :
//                       Text(
//                         'Cast',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       SizedBox(height: 20),

//                       CastView(id: movie.id),

//                       SizedBox(height: 20),

//                       HorizintalLine(),

//                       SizedBox(height: 18),

//                       /// similiar movies :
//                       Text(
//                         'Similar Movies',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SimiliarMoviesView(id: movie.id),
//                       SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Center(child: const CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> fetchTrailer() async {
//     final videos = await MoviesServices().getMovieVideos(widget.id);

//     if (videos.isEmpty) return;
//     final trailer = videos.first;

//     setState(() {
//       trailerKey = trailer.key;
//       isLoadingTrailer = false;
//     });
//   }

//   Future<void> openTrailer() async {
//     if (trailerKey == null) return;

//     await launchUrl(
//       Uri.parse("https://www.youtube.com/watch?v=$trailerKey"),
//       mode: LaunchMode.externalApplication,
//     );
//   }
// }

// =======================================================================================
// screen 2

// the row under the stack

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/components/cast_view.dart';
import 'package:movies_app/components/details_row.dart';
import 'package:movies_app/components/horizintal_line.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/components/similiar_movies_view.dart';
import 'package:movies_app/components/trailer_button.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/cubits/add_favourite_cubit/add_favourite_cubit.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/services/favourite_services.dart';
import 'package:movies_app/services/movies_sevices.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.id});
  final int id;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String? trailerKey = '';
  bool isLoadingTrailer = true;

  late MovieDetailsModel movie;

  @override
  void initState() {
    super.initState();
    fetchTrailer();
  }

  @override
  Widget build(BuildContext context) {
    // Color favColor = Colors.white;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   surfaceTintColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.arrow_back_ios_new),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //       Text(
      //         'Details',
      //         style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           setState(() {
      //             BlocProvider.of<AddFavCubit>(
      //               context,
      //             ).addFavourite(movie.toMovieModel());
      //             BlocProvider.of<FavCubit>(context).fetchAllFav();
      //           });
      //         },
      //         icon: FavouritesService().isFavourite(widget.id)
      //             ? Icon(Icons.bookmark, color: kIconsColor, size: 28)
      //             : Icon(Icons.bookmark_border, color: Colors.white, size: 28),
      //       ),
      //     ],
      //   ),
      // ),
      body: FutureBuilder(
        future: MoviesServices().getMovieDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            movie = snapshot.data!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      movie.backdropPath.isEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(6),
                              child: Image.asset('assets/backdrop.png'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                                // height: 250,
                                // width: double.infinity,
                                // fit: BoxFit.cover,
                              ),
                            ),

                      Positioned(
                        // top: 100,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                // Colors.red,
                                // Colors.black,
                                kPrimaryColor,
                                kPrimaryColor.withAlpha(50),
                                kPrimaryColor.withAlpha(5),
                                // kPrimaryColor,
                                // Colors.transparent,
                                // Colors.transparent,

                                // Colors.yellow
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        left: 16,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(120),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 30,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(120),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.bookmark,
                            size: 22,
                            color: kTextColor,
                          ),
                        ),
                      ),

                      // rating
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 8,
                      //     vertical: 3,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Colors.black.withAlpha(100),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       const Icon(
                      //         Icons.star_border_sharp,
                      //         size: 18,
                      //         color: Colors.orangeAccent,
                      //       ),
                      //       const SizedBox(width: 5),
                      //       Text(
                      //         movie.voteAverage.toString().substring(0, 3),
                      //         style: const TextStyle(
                      //           fontSize: 14,
                      //           // color: kTextColor,
                      //           color: Colors.orangeAccent,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  // SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              // movie title
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),

                              Container(
                                // margin: const EdgeInsets.all(8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white.withAlpha(25),
                                  border: Border.all(
                                    color: Colors.grey.withAlpha(25),
                                    width: 0.8,
                                  ),
                                  // color: kTextColor.withAlpha(60),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_border_sharp,
                                      size: 18,
                                      color: Colors.orangeAccent,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      movie.voteAverage.toString().substring(
                                        0,
                                        3,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        // color: kTextColor,
                                        color: Colors.orangeAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18),
                              // trailer
                              TrailerButton(
                                movieId: movie.id,
                                onTap: () {
                                  trailerKey!.isEmpty
                                      ? showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: Text(
                                                'No trailer available !',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : openTrailer();
                                },
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                        // poster
                        MovieItem(
                          movieImage: movie.posterPath,
                          height: 170,
                          width: 115,
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(height: 160),

                  // const Spacer(),

                  // Spacer(),
                  // SizedBox(height: 16),
                  HorizintalLine(),

                  DetailsRow(movie: movie),

                  HorizintalLine(),

                  SizedBox(height: 18),

                  /// about movie :
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'About Movie ',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      movie.overview.isEmpty ? 'No overview' : movie.overview,
                      style: TextStyle(fontSize: 14, color: kTextColor),
                    ),
                  ),
                  SizedBox(height: 18),
                  HorizintalLine(),
                  SizedBox(height: 18),

                  /// cast :
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Cast',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CastView(id: movie.id),
                  ),

                  SizedBox(height: 20),

                  HorizintalLine(),

                  SizedBox(height: 18),

                  /// similiar movies :
                  Text(
                    'Similar Movies',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  SimiliarMoviesView(id: movie.id),
                  SizedBox(height: 16),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }

  //
  Future<void> fetchTrailer() async {
    final videos = await MoviesServices().getMovieVideos(widget.id);

    if (videos.isEmpty) return;
    final trailer = videos.first;

    setState(() {
      trailerKey = trailer.key;
      isLoadingTrailer = false;
    });
  }

  Future<void> openTrailer() async {
    if (trailerKey == null) return;

    await launchUrl(
      Uri.parse("https://www.youtube.com/watch?v=$trailerKey"),
      mode: LaunchMode.externalApplication,
    );
  }
}

// ===================================================================

// screen 3
// all the row in the stack

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movies_app/components/cast_view.dart';
// import 'package:movies_app/components/details_row.dart';
// import 'package:movies_app/components/horizintal_line.dart';
// import 'package:movies_app/components/movie_item.dart';
// import 'package:movies_app/components/similiar_movies_view.dart';
// import 'package:movies_app/components/trailer_button.dart';
// import 'package:movies_app/constant.dart';
// import 'package:movies_app/cubits/add_favourite_cubit/add_favourite_cubit.dart';
// import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
// import 'package:movies_app/models/movie_details_model.dart';
// import 'package:movies_app/services/favourite_services.dart';
// import 'package:movies_app/services/movies_sevices.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MovieDetails extends StatefulWidget {
//   const MovieDetails({super.key, required this.id});
//   final int id;

//   @override
//   State<MovieDetails> createState() => _MovieDetailsState();
// }

// class _MovieDetailsState extends State<MovieDetails> {
//   String? trailerKey = '';
//   bool isLoadingTrailer = true;

//   late MovieDetailsModel movie;

//   @override
//   void initState() {
//     super.initState();
//     fetchTrailer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Color favColor = Colors.white;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         surfaceTintColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back_ios_new),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             Text(
//               'Details',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   BlocProvider.of<AddFavCubit>(
//                     context,
//                   ).addFavourite(movie.toMovieModel());
//                   BlocProvider.of<FavCubit>(context).fetchAllFav();
//                 });
//               },
//               icon: FavouritesService().isFavourite(widget.id)
//                   ? Icon(Icons.bookmark, color: kIconsColor, size: 28)
//                   : Icon(Icons.bookmark_border, color: Colors.white, size: 28),
//             ),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: FutureBuilder(
//           future: MoviesServices().getMovieDetails(widget.id),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               movie = snapshot.data!;
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           movie.backdropPath.isEmpty
//                               ? Image.asset('assets/backdrop.png')
//                               : ClipRRect(
//                                   borderRadius: BorderRadiusGeometry.circular(
//                                     6,
//                                   ),
//                                   child: Image.network(
//                                     'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
//                                   ),
//                                 ),

//                           Positioned(
//                             // top: 100,
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             height: 70,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.center,
//                                   colors: [
//                                     // Colors.red,
//                                     // Colors.black,
//                                     kPrimaryColor,
//                                     // kPrimaryColor.withAlpha(200),
//                                     // kPrimaryColor,
//                                     Colors.transparent,
//                                     // Colors.transparent,

//                                     // Colors.yellow
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),

//                           // rating
//                           Container(
//                             margin: const EdgeInsets.all(8),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 3,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.black.withAlpha(100),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 const Icon(
//                                   Icons.star_border_sharp,
//                                   size: 18,
//                                   color: Colors.orangeAccent,
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Text(
//                                   movie.voteAverage.toString().substring(0, 3),
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     // color: kTextColor,
//                                     color: Colors.orangeAccent,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           Positioned(
//                             top: 193,
//                             // bottom: 0,
//                             left: 0,
//                             right: 10,

//                             child: Container(
//                               width:MediaQuery.of(context).size.width * 0.95,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       // mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 22),
//                                         // movie title
//                                         Text(
//                                           movie.title,
//                                           style: TextStyle(
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 16),
//                                         // rating
//                                         Container(
//                                           // margin: const EdgeInsets.all(8),
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 8,
//                                             vertical: 3,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               12,
//                                             ),
//                                             color: Colors.white.withAlpha(25),
//                                             // color: kTextColor.withAlpha(60),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               const Icon(
//                                                 Icons.star_border_sharp,
//                                                 size: 18,
//                                                 color: Colors.orangeAccent,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               Text(
//                                                 movie.voteAverage
//                                                     .toString()
//                                                     .substring(0, 3),
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                   // color: kTextColor,
//                                                   color: Colors.orangeAccent,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 16),
//                                         // trailer
//                                         TrailerButton(
//                                           movieId: movie.id,
//                                           onTap: () {
//                                             trailerKey!.isEmpty
//                                                 ? showDialog(
//                                                     context: context,
//                                                     builder: (context) {
//                                                       return Center(
//                                                         child: Text(
//                                                           'No trailer available !',
//                                                           style: TextStyle(
//                                                             fontSize: 16,
//                                                             color: kTextColor,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                   )
//                                                 : openTrailer();
//                                           },
//                                         ),
//                                         SizedBox(height: 16),
//                                       ],
//                                     ),
//                                   ),
//                                   // poster
//                                   MovieItem(
//                                     movieImage: movie.posterPath,
//                                     height: 175,
//                                     width: 115,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // SizedBox(height: 5),

//                       SizedBox(height: 160),

//                       // const Spacer(),

//                       // Spacer(),
//                       // SizedBox(height: 16),
//                       HorizintalLine(),

//                       DetailsRow(movie: movie),

//                       HorizintalLine(),

//                       SizedBox(height: 18),

//                       /// about movie :
//                       Text(
//                         'About Movie ',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Text(
//                         movie.overview.isEmpty ? 'No overview' : movie.overview,
//                         style: TextStyle(fontSize: 16, color: kTextColor),
//                       ),
//                       SizedBox(height: 18),
//                       HorizintalLine(),
//                       SizedBox(height: 18),

//                       /// cast :
//                       Text(
//                         'Cast',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       SizedBox(height: 20),

//                       CastView(id: movie.id),

//                       SizedBox(height: 20),

//                       HorizintalLine(),

//                       SizedBox(height: 18),

//                       /// similiar movies :
//                       Text(
//                         'Similar Movies',
//                         style: TextStyle(
//                           color: kTextColor,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SimiliarMoviesView(id: movie.id),
//                       SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Center(child: const CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }

//   //
//   Future<void> fetchTrailer() async {
//     final videos = await MoviesServices().getMovieVideos(widget.id);

//     if (videos.isEmpty) return;
//     final trailer = videos.first;

//     setState(() {
//       trailerKey = trailer.key;
//       isLoadingTrailer = false;
//     });
//   }

//   Future<void> openTrailer() async {
//     if (trailerKey == null) return;

//     await launchUrl(
//       Uri.parse("https://www.youtube.com/watch?v=$trailerKey"),
//       mode: LaunchMode.externalApplication,
//     );
//   }
// }
