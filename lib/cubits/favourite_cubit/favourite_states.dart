import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavSuccess extends FavState {
  final List<MovieModel> movies;
  FavSuccess({required this.movies});
}

class FavNull extends FavState {
  final String errMessage;

  FavNull({required this.errMessage});
}
