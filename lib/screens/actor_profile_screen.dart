import 'package:flutter/material.dart';
import 'package:movies_app/components/expandable_text.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/helper/claculate_age.dart';
import 'package:movies_app/models/actor_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/movie_details_page.dart';
import 'package:movies_app/services/movies_sevices.dart';

class ActorProfileScreen extends StatefulWidget {
  final int actorId;

  const ActorProfileScreen({super.key, required this.actorId});

  @override
  State<ActorProfileScreen> createState() => _ActorProfileScreenState();
}

class _ActorProfileScreenState extends State<ActorProfileScreen> {
  late Future<ActorModel> actorFuture;
  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();
    actorFuture = MoviesServices().getActorProfile(widget.actorId);
    moviesFuture = MoviesServices().getActorMovies(widget.actorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: kTextColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text(
              '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<ActorModel>(
        future: actorFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final actor = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 8.0,
                //     vertical: 5.0,
                //   ),
                //   child: IconButton(
                //     padding: EdgeInsets.zero,
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     icon: Icon(Icons.arrow_back_ios_new, color: kTextColor),
                //   ),
                // ),
                // SizedBox(height: 23,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(14),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                          height: 375,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        child: Text(
                          actor.name,
                          style: const TextStyle(
                            color: Colors.white,
                            // color: kIconsColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 140,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                // Colors.black,
                                Colors.black.withAlpha(210),
                                // kPrimaryColor,
                                // kPrimaryColor.withAlpha(250),
                                // kPrimaryColor.withAlpha(25),
                                Colors.transparent,
                                // Colors.yellow
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Birthday : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            actor.birthday == '' || actor.birthday == null ? 'Not available !' : 
                            actor.birthday.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Age : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 280,
                            child: Text(
                              '${Helper.calculateAge(actor.birthday)} years old', style: TextStyle(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.w400,
                            ), ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Place : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 280,
                            child: Text(
                              actor.placeOfBirth == '' || actor.placeOfBirth == null ? 'Not available !' : 
                              actor.placeOfBirth.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Biograph",
                        style: TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      actor.biography.isEmpty
                          ? const Text(
                              "No biography available.",
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          : actor.biography.length < 300
                          ? Text(
                              actor.biography,
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            )
                          : ExpandableText(text: actor.biography, trimLines: 6),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    "Movies",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ),

                SizedBox(
                  height: 220,
                  child: FutureBuilder<List<MovieModel>>(
                    future: moviesFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetails(id: movie.id),
                                  ),
                                );
                              },
                              child: MovieItem(
                                movieImage: movie.poster,
                                height: 150,
                                width: 118,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================================

// screen 2 
// import 'package:flutter/material.dart';
// import 'package:movies_app/components/movie_item.dart';
// import 'package:movies_app/constant.dart';
// import 'package:movies_app/models/actor_model.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/services/movies_sevices.dart';

// class ActorProfileScreen extends StatefulWidget {
//   final int actorId;

//   const ActorProfileScreen({super.key, required this.actorId});

//   @override
//   State<ActorProfileScreen> createState() => _ActorProfileScreenState();
// }

// class _ActorProfileScreenState extends State<ActorProfileScreen> {
//   late Future<ActorModel> actorFuture;
//   late Future<List<MovieModel>> moviesFuture;

//   @override
//   void initState() {
//     super.initState();
//     actorFuture = MoviesServices().getActorProfile(widget.actorId);
//     moviesFuture = MoviesServices().getActorMovies(widget.actorId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<ActorModel>(
//         future: actorFuture,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final actor = snapshot.data!;

//           return CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 450,
//                 pinned: true,
//                 backgroundColor: Colors.black,
//                 flexibleSpace: FlexibleSpaceBar(
//                   title: Text(
//                     actor.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network(
//                         'https://image.tmdb.org/t/p/w500${actor.profilePath}',
//                         fit: BoxFit.cover,
//                       ),

//                       Container(
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.center,
//                             colors: [
//                               // Colors.red,
//                               Colors.black,
//                               Colors.transparent,
//                               // Colors.yellow
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.cake, color: kTextColor),
//                           const SizedBox(width: 6),
//                           Text(
//                             actor.birthday ?? "Unknown",
//                             style: const TextStyle(
//                               color: kTextColor,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 6),

//                       Row(
//                         children: [
//                           const Icon(Icons.location_on, color: kTextColor),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             child: Text(
//                               actor.placeOfBirth ?? "Unknown",
//                               style: const TextStyle(
//                                 color: kTextColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),

//                       const Text(
//                         "Biography",
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: kTextColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       Text(
//                         actor.biography.isEmpty
//                             ? "No biography available."
//                             : actor.biography,
//                         style: const TextStyle(
//                           height: 1.5,
//                           color: kTextColor,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       const Text(
//                         "Movies ",
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: kTextColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),

              
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 220,
//                   child: FutureBuilder<List<MovieModel>>(
//                     future: moviesFuture,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const Center(child: CircularProgressIndicator());
//                       }

//                       final movies = snapshot.data!;

//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: movies.length,
//                         itemBuilder: (context, index) {
//                           final movie = movies[index];

//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: MovieItem(
//                               movieImage: movie.poster,
//                               height: 150,
//                               width: 118,
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
