import 'package:flutter/material.dart';
import 'package:movie_challenge/models/movie_now_model.dart';
import 'package:movie_challenge/models/movie_popular_model.dart';
import 'package:movie_challenge/models/movie_soon_model.dart';
import 'package:movie_challenge/services/api_services.dart';
import 'package:movie_challenge/widgets/movie_now_widget.dart';
import 'package:movie_challenge/widgets/movie_soon_widget.dart';
import 'package:movie_challenge/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MoviePopularModel>> moviepopulars =
      ApiService.getPopularMovies();

  final Future<List<MovieNowModel>> movienows = ApiService.getNowMovies();

  final Future<List<MovieSoonModel>> moviesoons = ApiService.getSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 23, 34),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Transform.translate(
              offset: const Offset(20, 40),
              child: const Text(
                'Popular Movies',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
            FutureBuilder(
              future: moviepopulars,
              builder: (contextpop, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 450,
                        width: 3000,
                        child: makePopularList(snapshot),
                      ), // 높이가 얼마나 긴지 몰라서(무한대) Expanded를 넣어줘야 함
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Transform.translate(
              offset: const Offset(20, -150),
              child: const Text(
                'Playing-Now Movies',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -140),
              child: FutureBuilder(
                future: movienows,
                builder: (contextnow, snapshotnow) {
                  if (snapshotnow.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 450,
                          width: 3000,
                          child: makeNowList(snapshotnow),
                        ), // 높이가 얼마나 긴지 몰라서(무한대) Expanded를 넣어줘야 함
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.translate(
              offset: const Offset(20, -340),
              child: const Text(
                'Coming-Soon Movies',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -330),
              child: FutureBuilder(
                future: moviesoons,
                builder: (contextsoon, snapshotsoon) {
                  if (snapshotsoon.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 450,
                          width: 3000,
                          child: makeSoonList(snapshotsoon),
                        ), // 높이가 얼마나 긴지 몰라서(무한대) Expanded를 넣어줘야 함
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makePopularList(AsyncSnapshot<List<MoviePopularModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal, // 수평 방향 스크롤
      itemCount: snapshot.data!.length, // 한 번에 몇 개 보여줄건지
      itemBuilder: (contextpop, index) {
        var moviepopular = snapshot.data![index];
        return Movie(
          // Movie라는 위젯을 렌더링.
          title: moviepopular.title,
          posterPath: moviepopular.posterPath,
          id: moviepopular.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      // 반드시 필요한 함수. 뭘로 구분할 건지를 만드는거임
    );
  }

  ListView makeNowList(AsyncSnapshot<List<MovieNowModel>> snapshotnow) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal, // 수평 방향 스크롤
      itemCount: snapshotnow.data!.length, // 한 번에 몇 개 보여줄건지
      itemBuilder: (contextnow, index) {
        var movienow = snapshotnow.data![index];
        return MovieNow(
          // MovieNow라는 위젯을 렌더링.
          title: movienow.title,
          posterPath: movienow.posterPath,
          nowid: movienow.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      // 반드시 필요한 함수. 뭘로 구분할 건지를 만드는거임
    );
  }

  ListView makeSoonList(AsyncSnapshot<List<MovieSoonModel>> snapshotsoon) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal, // 수평 방향 스크롤
      itemCount: snapshotsoon.data!.length, // 한 번에 몇 개 보여줄건지
      itemBuilder: (contextsoon, index) {
        var moviesoon = snapshotsoon.data![index];
        return MovieSoon(
          // MovieSoon라는 위젯을 렌더링.
          title: moviesoon.title,
          posterPath: moviesoon.posterPath,
          soonid: moviesoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      // 반드시 필요한 함수. 뭘로 구분할 건지를 만드는거임
    );
  }
}
