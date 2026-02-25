import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';

@immutable
abstract class AddFavState {}

class AddFavInitial extends AddFavState {}

class AddFavLoading extends AddFavState {}

class AddFavSuccess extends AddFavState {
  final MovieModel movie;
  AddFavSuccess({required this.movie});
}

class AddFavFailure extends AddFavState {
  final String errMessage;
  AddFavFailure({required this.errMessage});
}
