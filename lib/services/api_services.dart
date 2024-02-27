import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_challenge/models/movie_detail_model.dart';
import 'package:movie_challenge/models/movie_now_model.dart';
import 'package:movie_challenge/models/movie_popular_model.dart';
import 'package:movie_challenge/models/movie_soon_model.dart';

class ApiService {
  static const String popularURL =
      "https://movies-api.nomadcoders.workers.dev/popular";
  static const String soonURL =
      "https://movies-api.nomadcoders.workers.dev/coming-soon";

  static const String nowURL =
      "https://movies-api.nomadcoders.workers.dev/now-playing";

  static const String detailURL =
      "https://movies-api.nomadcoders.workers.dev/movie?id=";

  static Future<List<MoviePopularModel>> getPopularMovies() async {
    List<MoviePopularModel> moviepopularInstances =
        []; // MoviePopularModel 클래스를 가지는 List 생성
    final url = Uri.parse(popularURL); 
    final response = // API를 요청
        await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> moviepopulars = jsonDecode(response.body)['results'];
      for (var moviepopular in moviepopulars) {
        moviepopularInstances.add(MoviePopularModel.fromjson(moviepopular));
        // moviepopular JSON으로 MoviePopularModel 인스턴스를 생성.
        // 그리고 JSON은 Map임. key는 String, value는 dynamic.
      }
      return moviepopularInstances;
    }
    throw Error();
  }

  static Future<List<MovieNowModel>> getNowMovies() async {
    List<MovieNowModel> movienowInstances =
        []; // MoviePopularModel 클래스를 가지는 List 생성
    final url = Uri.parse(nowURL); // baseURL에 있는걸 popularURL 단위로 쪼갠다?
    final response = // API를 요청
        await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movienows = jsonDecode(response.body)['results'];
      for (var movienow in movienows) {
        movienowInstances.add(MovieNowModel.fromjson(movienow));
        // movienow JSON으로 MovieNowModel 인스턴스를 생성.
        // 그리고 JSON은 Map임. key는 String, value는 dynamic.
      }
      return movienowInstances;
    }
    throw Error();
  }

  static Future<List<MovieSoonModel>> getSoonMovies() async {
    List<MovieSoonModel> moviesoonInstances =
        []; // MoviePopularModel 클래스를 가지는 List 생성
    final url = Uri.parse(soonURL); // baseURL에 있는걸 popularURL 단위로 쪼갠다?
    final response = // API를 요청
        await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> moviesoons = jsonDecode(response.body)['results'];
      for (var moviesoon in moviesoons) {
        moviesoonInstances.add(MovieSoonModel.fromjson(moviesoon));
        // moviesoon JSON으로 MovieSoonModel 인스턴스를 생성.
        // 그리고 JSON은 Map임. key는 String, value는 dynamic.
      }
      return moviesoonInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse("$detailURL$id"); // baseurl에서 id를 찾아온다
    final response = await http.get(url); // url로 request 보냄
    if (response.statusCode == 200) {
      final moviedetail = jsonDecode(response.body);
      print(moviedetail);
      return MovieDetailModel.fromjson(moviedetail);
    }
    throw Error();
  }

  static Future<List<MovieGenreModel>> getGenreById(String id) async {
    List<MovieGenreModel> moviegenreInstances = [];
    final url = Uri.parse("$detailURL$id"); // baseurl에서 id를 찾아온다
    final response = await http.get(url); // url로 request 보냄
    if (response.statusCode == 200) {
      final List<dynamic> moviegenres = jsonDecode(response.body)['genres'];
      for (var moviegenre in moviegenres) {
        moviegenreInstances.add(MovieGenreModel.fromjson(moviegenre));
      }
      return moviegenreInstances;
    }
    throw Error();
  }
}
