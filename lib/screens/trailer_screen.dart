// import 'package:flutter/material.dart';
// import 'package:movies_app/models/video_model.dart';
// import 'package:movies_app/services/movies_sevices.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class TrailerScreen extends StatefulWidget {
//   const TrailerScreen({super.key, required this.movieId});
//   final int movieId;

//   @override
//   State<TrailerScreen> createState() => _TrailerScreenState();
// }

// class _TrailerScreenState extends State<TrailerScreen> {
//   late YoutubePlayerController _controller;
//   bool _isControllerReady = false;

//   @override
//   void dispose() {
//     if (_isControllerReady) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Trailer')),
//       body: FutureBuilder(
//         future: MoviesServices().getMovieVideos(widget.movieId),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<VideoModel> trailers = snapshot.data!;
//             if (trailers.isEmpty) {
//               return Center(child: Text("No trailer available"));
//             }
//             VideoModel trailer = trailers.first;

//             _controller = YoutubePlayerController(
//               initialVideoId: trailer.key,
//               flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//             );

//             return Center(
//               child: YoutubePlayer(
//                 controller: _controller,
//                 showVideoProgressIndicator: true,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// ========================================
import 'package:flutter/material.dart';
import 'package:movies_app/constant.dart';

class TrailerScreen extends StatelessWidget {
  const TrailerScreen({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             Text('Trailer'),
          ],
        ),
      ),
    );
  }
}
