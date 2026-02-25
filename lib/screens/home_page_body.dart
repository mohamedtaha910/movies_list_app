import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/components/no_connection_body.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/discover_screen.dart';
// import 'package:movies_app/screens/favourite_page.dart';
import 'package:movies_app/screens/movie_details_page.dart';
// import 'package:movies_app/screens/search_page.dart';
import 'package:movies_app/services/movies_sevices.dart';
import 'package:movies_app/shimmers/movie_shimmer.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
            // const Text(
            //   'Time ',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // const Text(
            //   'Movies',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.orange,
            //   ),
            // ),
            SvgPicture.asset('assets/Logo.svg' , height: 22,colorFilter:ColorFilter.mode(Color(0xfff53f3f).withAlpha(200), BlendMode.srcIn),),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                // color: kTextColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DiscoverScreen(),
                      ),
                    );
                  },
                  icon:SvgPicture.asset('assets/Search.svg', colorFilter:ColorFilter.mode(kTextColor, BlendMode.srcIn),),
                ),
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: MoviesServices().getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MovieModel> movies = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 8.0,
                // bottom: 16.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 18, //
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetails(id: movies[index].id),
                              ),
                            );
                          },
                          child: MovieItem(movieImage: movies[index].poster),
                        );
                      },
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return NoConnectionBody();
          } else {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 15,
                crossAxisSpacing: 18,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return const MovieShimmer();
              },
            );
          }
        },
      ),
    );
  }
}
