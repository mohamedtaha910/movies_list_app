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
  const FavouritePage({super.key,required this.isInProfile});
  final bool isInProfile ;

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
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.isInProfile == true ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<FavCubit>(context).fetchAllFav();
              },
            ) : SizedBox(width: 0,),
            // IconButton(
            //   icon: Icon(Icons.arrow_back_ios_new),
            //   onPressed: () {
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => HomePage()),
            //     );
            //   },
            // ),
            // Spacer(),
            // SizedBox(width: 42),
            Text(
              'Favourites',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  isSorted = !isSorted ;
                });
              },
              icon: Icon(Icons.swap_vert_rounded, color: Colors.white),
              padding: EdgeInsets.only(top: 12, bottom: 8),
            ),
          ],
        ),
      ),
      
      
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8 , bottom: 0),
        child: BlocBuilder<FavCubit, FavState>(
          builder: (context, state) {

            List<MovieModel> favourites = BlocProvider.of<FavCubit>(
              context,
            ).movies;
            List<MovieModel> reversedFavourites = favourites.reversed.toList();

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
                      ListView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: favourites.length,
                          itemBuilder: (context, index) {
                            MovieModel movie = isSorted
                                ? favourites[index]
                                : reversedFavourites[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: SearchedMovieItem(movie: movie),
                            );
                          },
                        ),
                        SizedBox(height: 70,),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}
