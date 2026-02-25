import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_states.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/services/favourite_services.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  late List<MovieModel> movies = [] ;

  fetchAllFav() async {
    emit(FavLoading());
    movies = FavouritesService().getAllFavourites();
    if (movies.isEmpty) {
      emit(FavNull(errMessage: 'No Favourites yet!'));
    } else {
      emit(FavSuccess(movies: movies));
    }
  }
}
