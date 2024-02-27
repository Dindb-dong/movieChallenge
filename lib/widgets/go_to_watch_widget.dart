import 'package:flutter/material.dart';
import 'package:movie_challenge/models/movie_detail_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GoToWatch extends StatelessWidget {
  const GoToWatch({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailModel movie;

  onButtonTap() async {
    if (movie.watchUrl != null) {
      await launchUrlString(movie.watchUrl!);
    } else {
      return ();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(135, 63, 58, 58),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Go to Watch",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
