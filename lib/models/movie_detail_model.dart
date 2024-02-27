class MovieDetailModel {
  final String title, overview, voteAverage;
  final String? watchUrl;

  MovieDetailModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        voteAverage = "${json['vote_average']}",
        watchUrl = json['homepage'];
}

class MovieGenreModel {
  final String genre;

  MovieGenreModel.fromjson(Map<String, dynamic> json) : genre = json['name'];
}
