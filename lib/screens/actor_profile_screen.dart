import 'package:flutter/cupertino.dart';
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
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   surfaceTintColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   title: Row(
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.arrow_back_ios_new, color: kTextColor),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //       const Text(
      //         '',
      //         style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: FutureBuilder<ActorModel>(
        future: actorFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final actor = snapshot.data!;

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          // borderRadius: BorderRadiusGeometry.circular(14),
                          child: actor.profilePath == ''
                              ? Image.asset(
                                  'assets/person.jpg',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                                  // height: 500,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        Positioned.fill(
                          // bottom: 0,
                          // left: 0,
                          // right: 0,
                          // height: 140,
                          // height: 250,
                          child: Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  kPrimaryColor.withAlpha(120),
                                  kPrimaryColor,
                                  // Colors.black,
                                  // Colors.black.withAlpha(210),

                                  // kPrimaryColor.withAlpha(250),

                                  // Colors.yellow
                                ],
                                stops: const [0.0, 0.45, 0.7, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                actor.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  // color: kIconsColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place_rounded,
                                    size: 22,
                                    color: Colors.white38,
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      actor.placeOfBirth == '' ||
                                              actor.placeOfBirth == null
                                          ? 'Not available !'
                                          : actor.placeOfBirth.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          // top: 20,
                          top: 36,
                          left: 16,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    // Colors.black.withAlpha(250),
                                    // Colors.black.withAlpha(200),
                                    // Colors.black.withAlpha(120),
                                    Colors.blueGrey.withAlpha(250),
                                    Colors.blueGrey.withAlpha(180),
                                    Colors.blueGrey.withAlpha(120),

                                    // kPrimaryColor.withAlpha(255),
                                    // kPrimaryColor.withAlpha(200),
                                    // kPrimaryColor.withAlpha(120),
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white.withAlpha(100),
                                    width: 0.8,
                                  ),
                                ),
                              ),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.cake_rounded,
                                label: 'Birthday',
                                value:
                                    (actor.birthday == '' ||
                                        actor.birthday == null)
                                    ? '—'
                                    : actor.birthday.toString(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.hourglass_bottom_rounded,
                                label: 'Age',
                                value: actor.birthday == null
                                    ? '—'
                                    : '${Helper.calculateAge(actor.birthday)} yrs',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          "Biograph",
                          style: TextStyle(
                            fontSize: 17,
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
                                  fontSize: 15,
                                ),
                              )
                            : actor.biography.length < 300
                            ? Text(
                                actor.biography,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              )
                            : ExpandableText(
                                text: actor.biography,

                                trimLines: 6,
                              ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: SizedBox(
                      height: 200,
                      child: FutureBuilder<List<MovieModel>>(
                        future: moviesFuture,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ===============================
// import 'package:flutter/material.dart';
// import 'package:movies_app/components/expandable_text.dart';
// import 'package:movies_app/components/movie_item.dart';
// import 'package:movies_app/constant.dart';
// import 'package:movies_app/helper/claculate_age.dart';
// import 'package:movies_app/models/actor_model.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/movie_details_page.dart';
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

//   static const double _expandedHeight = 460;

//   @override
//   void initState() {
//     super.initState();
//     actorFuture = MoviesServices().getActorProfile(widget.actorId);
//     moviesFuture = MoviesServices().getActorMovies(widget.actorId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: FutureBuilder<ActorModel>(
//         future: actorFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(color: kIconsColor),
//             );
//           }

//           if (!snapshot.hasData) {
//             return Center(
//               child: Text(
//                 'Something went wrong',
//                 style: TextStyle(color: kTextColor),
//               ),
//             );
//           }

//           final actor = snapshot.data!;

//           return CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               SliverAppBar(
//                 pinned: true,
//                 stretch: true,
//                 backgroundColor: kPrimaryColor,
//                 surfaceTintColor: Colors.transparent,
//                 expandedHeight: _expandedHeight,
//                 automaticallyImplyLeading: false,
//                 leading: Padding(
//                   padding: const EdgeInsets.only(left: 12, top: 4),
//                   child: _CircleIconButton(
//                     icon: Icons.chevron_left_rounded,
//                     onTap: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   stretchModes: const [
//                     StretchMode.zoomBackground,
//                     StretchMode.fadeTitle,
//                   ],

//                   background: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Hero(
//                         tag: 'actor_${widget.actorId}',
//                         child: actor.profilePath == ''
//                             ? Image.asset(
//                                 'assets/person.jpg',
//                                 fit: BoxFit.cover,
//                               )
//                             : Image.network(
//                                 'https://image.tmdb.org/t/p/w500${actor.profilePath}',
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       // Bottom fade so the name sits on a legible surface.
//                       Positioned.fill(
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Colors.transparent,
//                                 Colors.transparent,
//                                 kPrimaryColor.withAlpha(140),
//                                 kPrimaryColor,
//                               ],
//                               stops: const [0.0, 0.45, 0.75, 1.0],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 20,
//                         right: 20,
//                         bottom: 22,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               actor.name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 height: 1.1,
//                                 shadows: [
//                                   Shadow(color: Colors.black54, blurRadius: 12),
//                                 ],
//                               ),
//                             ),
//                             if (actor.placeOfBirth != null &&
//                                 actor.placeOfBirth != '')
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 6),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const Icon(
//                                       Icons.place_rounded,
//                                       size: 15,
//                                       color: Colors.white70,
//                                     ),
//                                     const SizedBox(width: 4),
//                                     Flexible(
//                                       child: Text(
//                                         actor.placeOfBirth.toString(),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SliverToBoxAdapter(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 18),

//                     // Stat chips row: Birthday / Age.
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.cake_rounded,
//                               label: 'Birthday',
//                               value:
//                                   (actor.birthday == '' ||
//                                       actor.birthday == null)
//                                   ? '—'
//                                   : actor.birthday.toString(),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _StatCard(
//                               icon: Icons.hourglass_bottom_rounded,
//                               label: 'Age',
//                               value: actor.birthday == null
//                                   ? '—'
//                                   : '${Helper.calculateAge(actor.birthday)} yrs',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const _SectionTitle(title: 'Biography'),
//                           const SizedBox(height: 10),
//                           actor.biography.isEmpty
//                               ? Text(
//                                   'No biography available.',
//                                   style: TextStyle(
//                                     color: kTextColor.withAlpha(180),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     height: 1.5,
//                                   ),
//                                 )
//                               : actor.biography.length < 300
//                               ? Text(
//                                   actor.biography,
//                                   style: TextStyle(
//                                     color: kTextColor.withAlpha(220),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     height: 1.5,
//                                   ),
//                                 )
//                               : ExpandableText(
//                                   text: actor.biography,
//                                   trimLines: 6,
//                                 ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 26),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: const _SectionTitle(title: 'Known For'),
//                     ),
//                     const SizedBox(height: 14),

//                     SizedBox(
//                       height: 210,
//                       child: FutureBuilder<List<MovieModel>>(
//                         future: moviesFuture,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                 color: kIconsColor,
//                               ),
//                             );
//                           }

//                           final movies = snapshot.data ?? [];

//                           if (movies.isEmpty) {
//                             return Center(
//                               child: Text(
//                                 'No movies found',
//                                 style: TextStyle(
//                                   color: kTextColor.withAlpha(150),
//                                 ),
//                               ),
//                             );
//                           }

//                           return ListView.builder(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: movies.length,
//                             itemBuilder: (context, index) {
//                               final movie = movies[index];

//                               return Padding(
//                                 padding: const EdgeInsets.only(right: 12),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             MovieDetails(id: movie.id),
//                                       ),
//                                     );
//                                   },
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(14),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(14),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withAlpha(60),
//                                             blurRadius: 10,
//                                             offset: const Offset(0, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: MovieItem(
//                                         movieImage: movie.poster,
//                                         height: 100,
//                                         width: 120,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;

//   const _SectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 18,
//           decoration: BoxDecoration(
//             color: kIconsColor,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: kTextColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(20)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: kIconsColor.withAlpha(40),
              color: Colors.black.withAlpha(25),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withAlpha(25)),
            ),
            child: Icon(icon, size: 18, color: kIconsColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: kTextColor.withAlpha(150),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIconButton({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: Colors.black.withAlpha(90),
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white.withAlpha(40)),
//         ),
//         child: Icon(icon, size: 26, color: Colors.white),
//       ),
//     );
//   }
// }
