
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubits/add_favourite_cubit/add_favourite_states.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/services/favourite_services.dart';

class AddFavCubit extends Cubit<AddFavState> {

  
  AddFavCubit() : super(AddFavInitial());
  
  void addFavourite(MovieModel movie) {
    emit(AddFavLoading());
    FavouritesService().addFavourite(movie);
    emit(AddFavSuccess(movie: movie));
  }
}