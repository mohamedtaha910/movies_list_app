class ActorModel {
  final int id;
  final String name;
  final String biography;
  final String? birthday;
  final String? placeOfBirth;
  final String? profilePath;
  final double popularity;

  ActorModel({
    required this.id,
    required this.name,
    required this.biography,
    this.birthday,
    this.placeOfBirth,
    this.profilePath,
    required this.popularity,
  });

  factory ActorModel.fromJson(json) {
    return ActorModel(
      id: json['id'],
      name: json['name'] ?? '',
      biography: json['biography'] ?? '',
      birthday: json['birthday'] ?? '',
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
      popularity: (json['popularity'] as num).toDouble(),
    );
  }
}
