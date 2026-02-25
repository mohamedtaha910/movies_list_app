import 'package:flutter/material.dart';
import 'package:movies_app/components/category_item.dart';
// import 'package:movies_app/components/custom_text_field.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/screens/category_screen.dart';
import 'package:movies_app/screens/home_page.dart';
import 'package:movies_app/screens/search_page.dart';
import 'package:movies_app/services/movies_sevices.dart';
import 'package:movies_app/shimmers/movie_shimmer.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                // color: Colors.white,
                color: kTextColor,
              ),
            ),
            // const SizedBox(width: 5),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (contaxt) => const SearchPage()),
                  );
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 0 , vertical: 50),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                  decoration: BoxDecoration(
                    color: Colors.white70.withAlpha(25),
                    borderRadius: BorderRadius.circular(100),
                    // border: Border.all(color: kTextColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 24,
                        color: kTextColor.withAlpha(120),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Search Movies',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kTextColor.withAlpha(120),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: MoviesServices().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> categories = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8,
                top: 16,

                // bottom: 3,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 16),
                    Text(
                      'Genres',
                      style: TextStyle(
                        fontSize: 24,
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3.2,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        CategoryModel category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryScreen(category: category),
                              ),
                            );
                          },
                          child: CategoryItem(categoryName: category.name),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 10,
                childAspectRatio: 2.3,
              ),
              itemCount: 14,
              itemBuilder: (context, index) {
                return MovieShimmer();
              },
            );
          }
        },
      ),
    );
  }
}
