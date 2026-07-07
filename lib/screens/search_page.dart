import 'package:flutter/material.dart';
import 'package:movies_app/components/custom_text_field.dart';
import 'package:movies_app/components/no_connection_body.dart';
// import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/components/searched_movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/screens/home_page.dart';
// import 'package:movies_app/screens/home_page_body.dart';
import 'package:movies_app/services/movies_sevices.dart';
// import 'package:movies_app/shimmers/movie_shimmer.dart';
import 'package:movies_app/shimmers/searched_movie_shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? movieName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // leadingWidth: 0,
        title: Row(
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
                color: kTextColor,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CustomTextField(
                onChanged: (value) {
                  setState(() {
                    movieName = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),

      body: movieName == ''
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Start searching ',
                    style: TextStyle(
                      fontSize: 18,
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.movie_creation_outlined,
                    size: 24,
                    color: kTextColor,
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: MoviesServices().searchMovies(movieName!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> movies = snapshot.data!;
                  if (movies.isEmpty) {
                    return Center(
                      child: Text(
                        'No movies found ! ',
                        style: TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SearchedMovieItem(movie: movies[index]),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return NoConnectionBody();
                } else {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const SearchedMovieShimmer(),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
