import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/models/cast_model.dart';
// import 'package:movies_app/screens/actor_movies_screen.dart';
import 'package:movies_app/screens/actor_profile_screen.dart';
import 'package:movies_app/services/movies_sevices.dart';

class CastView extends StatelessWidget {
  const CastView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    List<CastModel> castList = [];
    return FutureBuilder(
      future: MoviesServices().getMovieCast(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          castList = snapshot.data as List<CastModel>;
          return castList.isEmpty
              ? Center(
                  child: const Text(
                    'The cast is not available !',
                    style: TextStyle(
                      fontSize: 14,
                      color: kTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      castList.length,
                      (index) => Container(
                        // height: 200,
                        width: 110,
                        margin: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ActorProfileScreen(
                                  actorId: castList[index].id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 43,
                                backgroundColor: Colors.grey.withAlpha(50),
                                child: CircleAvatar(
                                  radius: 42,

                                  backgroundImage:
                                      castList[index].profilePath.isEmpty
                                      ? AssetImage('assets/person.jpg')
                                      : NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${castList[index].profilePath}',
                                        ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                // castList[index].name.length >= 10
                                //     ? '${castList[index].name.substring(0, 10)}...'
                                //     :
                                castList[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                // castList[index].character.length >= 10
                                //     ? '${castList[index].character.substring(0, 10)}...'
                                //     :
                                '( ${castList[index].character} )',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        } else if (snapshot.hasError) {
          return Text(' The cast is Not Available');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
