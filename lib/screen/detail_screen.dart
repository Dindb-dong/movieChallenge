import 'package:flutter/material.dart';
import 'package:movie_challenge/models/movie_detail_model.dart';
import 'package:movie_challenge/services/api_services.dart';
import 'package:movie_challenge/widgets/go_to_watch_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, posterPath, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;
  late Future<List<MovieGenreModel>> genres;
  late Future<MovieDetailModel> gtw;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
    genres = ApiService.getGenreById(widget.id);
    gtw = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 31, 31),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 1, 1, 0.0),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Back to the List",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 226, 226, 226),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Hero(tag: widget.id, child: BackgroundImage(widget: widget)),
              Positioned(
                bottom: 30,
                left: 15,
                right: 15,
                child: Column(
                  children: [
                    Column(
                      children: [
                        MovieTitle(widget: widget),
                        const SizedBox(
                          height: 20,
                        ),
                        Genre(genres: genres),
                      ],
                    ),
                    RateAndStoryLine(movie: movie),
                    FutureBuilder(
                      future: movie,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GoToWatch(movie: snapshot.data!);
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    super.key,
    required this.widget,
  });

  final DetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class RateAndStoryLine extends StatelessWidget {
  const RateAndStoryLine({
    super.key,
    required this.movie,
  });

  final Future<MovieDetailModel> movie;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rate : ${snapshot.data!.voteAverage} / 10",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Storyline",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      snapshot.data!.overview,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }
        return const Text(
          "...",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }
}

class Genre extends StatelessWidget {
  const Genre({
    super.key,
    required this.genres,
  });

  final Future<List<MovieGenreModel>> genres;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: genres,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              for (var episode in snapshot.data!)
                Text(
                  "${episode.genre} | ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              // 장르 리스트 만들고, 거기다가 snap~~데이터에 있는 장르들을 다 담아줌. 이후에 그거 리턴해서 보여주면 됨
            ],
          );
        }
        return Container();
      },
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.widget,
  });

  final DetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5), // 투명도 조절, 0.0은 완전 투명, 1.0은 불투명
          BlendMode.dstATop),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          widget.posterPath,
          headers: const {
            'Referer': 'https://www.netflix.com',
          },
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
