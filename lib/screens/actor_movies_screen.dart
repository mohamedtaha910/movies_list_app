import 'package:flutter/material.dart';
import 'package:movies_app/components/horizintal_line.dart';
import 'package:movies_app/components/searched_movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/services/movies_sevices.dart';

class ActorMoviesScreen extends StatelessWidget {
  const ActorMoviesScreen({super.key, required this.actor});
  final CastModel actor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: kTextColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 16),
            Text(
              actor.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: MoviesServices().getActorMovies(actor.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else{
          List<MovieModel> movies = snapshot.data as List<MovieModel>;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: actor.profilePath.isEmpty
                        ? Image.asset(
                            'assets/person.jpg',
                            height: 200,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                            height: 200,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Actor / Actress',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  HorizintalLine(),
                  HorizintalLine(),
                  Text(
                    'Movies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SearchedMovieItem(movie: movies[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
          }
        }
      ),
    );
  }
}
