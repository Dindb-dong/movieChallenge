import 'package:flutter/material.dart';
import 'package:movie_challenge/screen/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, posterPath, id;

  const Movie({
    // 아래의 value들을 요구하는 위젯.
    super.key,
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 전체를 감싸줘야 함. 렌더링되는 모든 것 (포스터, 이름 등)을.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contextpop) => // context 정보가 필요하고, route를 push함/
                DetailScreen(
              title: title, // class 프로퍼티로 전달됨. 그래서 귀찮게 따로 다 지정할 필요x
              posterPath: posterPath,
              id: id,
            ), // route는 Stateless위젯을 원하는게 아님. route는 스크린'처럼'보이는 것임
            fullscreenDialog: true, // 풀스크린으로 보이게 함
          ),
        );
      },
      // 그걸 렌더링함.
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 150,
              clipBehavior: Clip.hardEdge, // 요소가 넘치면, 가장자리 부분 잘라버림.
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      offset: const Offset(5, 5),
                      color: Colors.black.withOpacity(0.7),
                    )
                  ]),
              child: Image.network(
                posterPath,
                headers: const {
                  'Referer': 'https://www.netflix.com',
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

