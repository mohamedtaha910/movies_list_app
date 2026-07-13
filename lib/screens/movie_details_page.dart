// // =======================================================================================
// // screen 2

// // the row under the stack

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/components/cast_view.dart';
import 'package:movies_app/components/details_row.dart';
import 'package:movies_app/components/expandable_text.dart';
import 'package:movies_app/components/horizintal_line.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/components/no_connection_body.dart';
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
    return Scaffold(
      body: FutureBuilder(
        future: MoviesServices().getMovieDetails(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            movie = snapshot.data!;
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
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
                                borderRadius: BorderRadiusGeometry.circular(0),
                                child: Image.asset('assets/backdrop.png'),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                                  height: 240,
                                  // width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),

                        Positioned.fill(
                          // top: 100,
                          // bottom: 0,
                          // left: 0,
                          // right: 0,
                          // height: 90,
                          child: Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  kPrimaryColor.withAlpha(120),
                                  kPrimaryColor,
                                ],
                                stops: const [0.0, 0.45, 0.8, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // top: 28,
                          top: 38,
                          left: 16,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                // color: Colors.black.withAlpha(180),
                                gradient: LinearGradient(
                                  colors: [
                                    // Colors.black.withAlpha(240),
                                    // Colors.black.withAlpha(190),
                                    // Colors.black.withAlpha(120),
                                    kPrimaryColor.withAlpha(255),
                                    kPrimaryColor.withAlpha(200),
                                    // kPrimaryColor.withAlpha(150),
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                size: 32,
                                color: kTextColor,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // top: 28,
                          top: 38,
                          right: 16,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                BlocProvider.of<AddFavCubit>(
                                  context,
                                ).addFavourite(movie.toMovieModel());
                                BlocProvider.of<FavCubit>(
                                  context,
                                ).fetchAllFav();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                // color: Colors.black.withAlpha(200),
                                gradient: LinearGradient(
                                  colors: [
                                    // Colors.black.withAlpha(240),
                                    // Colors.black.withAlpha(190),
                                    // Colors.black.withAlpha(120),
                                    kPrimaryColor.withAlpha(255),
                                    kPrimaryColor.withAlpha(200),
                                    // kPrimaryColor.withAlpha(120),
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: FavouritesService().isFavourite(widget.id)
                                  ? Icon(
                                      Icons.bookmark_added_rounded,
                                      color: kIconsColor,
                                      size: 24,
                                    )
                                  : Icon(
                                      Icons.bookmark_add_rounded,
                                      color: kTextColor,
                                      size: 24,
                                    ),
                            ),
                          ),
                        ),
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
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orangeAccent.withAlpha(50),
                                        Colors.orangeAccent.withAlpha(20),
                                      ],
                                      begin: AlignmentGeometry.topCenter,
                                      end: AlignmentGeometry.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.orangeAccent.withAlpha(
                                          50,
                                        ),
                                        width: 0.7,
                                      ),
                                    ),
                                    // color: kTextColor.withAlpha(60),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: Text(
                    //     movie.overview.isEmpty ? 'No overview' : movie.overview,
                    //     style: TextStyle(fontSize: 14, color: kTextColor),
                    //   ),
                    // ),
                    movie.overview.isEmpty
                        ? const Text(
                            "No Overview.",
                            style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          )
                        : movie.overview.length < 100
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              movie.overview,
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: ExpandableText(
                              text: movie.overview,
                              trimLines: 4,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Similar Movies',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, bottom: 6),
                      child: SimiliarMoviesView(id: movie.id),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return NoConnectionBody();
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
// ==================================
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
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: FutureBuilder(
//         future: MoviesServices().getMovieDetails(widget.id),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             movie = snapshot.data!;
//             return SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildBackdrop(context),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 6),
//                               Text(
//                                 movie.title,
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   height: 1.2,
//                                 ),
//                               ),
//                               const SizedBox(height: 14),
//                               _buildRatingChip(),
//                               const SizedBox(height: 18),
//                               TrailerButton(
//                                 movieId: movie.id,
//                                 onTap: () {
//                                   trailerKey!.isEmpty
//                                       ? _showNoTrailerDialog(context)
//                                       : openTrailer();
//                                 },
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//                         ),
//                         Hero(
//                           tag: 'movie_poster_${movie.id}',
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withAlpha(90),
//                                   blurRadius: 14,
//                                   offset: const Offset(0, 6),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(14),
//                               child: MovieItem(
//                                 movieImage: movie.posterPath,
//                                 height: 170,
//                                 width: 115,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 18),
//                   const HorizintalLine(),
//                   DetailsRow(movie: movie),
//                   const HorizintalLine(),
//                   const SizedBox(height: 20),

//                   _sectionHeader('About Movie'),
//                   const SizedBox(height: 12),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withAlpha(12),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.white.withAlpha(20)),
//                       ),
//                       child: Text(
//                         movie.overview.isEmpty
//                             ? 'No overview available.'
//                             : movie.overview,
//                         style: TextStyle(
//                           fontSize: 14,
//                           height: 1.5,
//                           color: kTextColor.withAlpha(220),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   const HorizintalLine(),
//                   const SizedBox(height: 20),

//                   _sectionHeader('Cast'),
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16.0),
//                     child: CastView(id: movie.id),
//                   ),
//                   const SizedBox(height: 22),
//                   const HorizintalLine(),
//                   const SizedBox(height: 20),

//                   _sectionHeader('Similar Movies'),
//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16.0, bottom: 6),
//                     child: SimiliarMoviesView(id: movie.id),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.error_outline_rounded,
//                     color: kTextColor.withAlpha(150),
//                     size: 40,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Something went wrong',
//                     style: TextStyle(color: kTextColor.withAlpha(200)),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: CircularProgressIndicator(color: kIconsColor));
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildBackdrop(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         AspectRatio(
//           aspectRatio: 16 / 9,
//           child: movie.backdropPath.isEmpty
//               ? Image.asset('assets/backdrop.png', fit: BoxFit.cover)
//               : Image.network(
//                   'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, progress) {
//                     if (progress == null) return child;
//                     return Container(
//                       color: Colors.white.withAlpha(15),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           color: kIconsColor,
//                           strokeWidth: 2,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ),
//         // Bottom fade so it blends into the content below
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           height: 90,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [kPrimaryColor, kPrimaryColor.withAlpha(0)],
//               ),
//             ),
//           ),
//         ),
//         // Top fade so the back/favourite buttons stay legible
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           height: 90,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withAlpha(120),
//                   Colors.black.withAlpha(0),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 45,
//           left: 16,
//           child: _circleIconButton(
//             icon: Icons.chevron_left_rounded,
//             onTap: () => Navigator.of(context).pop(),
//           ),
//         ),
//         Positioned(
//           top: 45,
//           right: 16,
//           child: _circleIconButton(
//             icon: FavouritesService().isFavourite(widget.id)
//                 ? Icons.bookmark_added_rounded
//                 : Icons.bookmark_add_rounded,
//             iconColor: FavouritesService().isFavourite(widget.id)
//                 ? kIconsColor
//                 : kTextColor,
//             onTap: () {
//               setState(() {
//                 BlocProvider.of<AddFavCubit>(
//                   context,
//                 ).addFavourite(movie.toMovieModel());
//                 BlocProvider.of<FavCubit>(context).fetchAllFav();
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _circleIconButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     Color? iconColor,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.black.withAlpha(160),
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white.withAlpha(30), width: 0.8),
//         ),
//         child: Icon(icon, size: 22, color: iconColor ?? kTextColor),
//       ),
//     );
//   }

//   Widget _buildRatingChip() {
//     final rating = movie.voteAverage.toStringAsFixed(1);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: Colors.orangeAccent.withAlpha(25),
//         border: Border.all(
//           color: Colors.orangeAccent.withAlpha(60),
//           width: 0.8,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.star_rounded, size: 18, color: Colors.orangeAccent),
//           const SizedBox(width: 5),
//           Text(
//             rating,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.orangeAccent,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         children: [
//           Container(
//             width: 4,
//             height: 18,
//             decoration: BoxDecoration(
//               color: kIconsColor,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               color: kTextColor,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showNoTrailerDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.white.withAlpha(30)),
//             ),
//             child: Text(
//               'No trailer available!',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: kTextColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       },
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
