import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_item.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/movie_details_page.dart';
import 'package:movies_app/services/movies_sevices.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.grey.shade100.withAlpha(50),
                    width: 0.3,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kTextColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              category.name,
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
        future: MoviesServices().getMoviesByCategory(category.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MovieModel> movies = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 15, //
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
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
