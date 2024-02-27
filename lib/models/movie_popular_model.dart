class MoviePopularModel {
  final String title, posterPath, id;
  static String urlImage = "https://image.tmdb.org/t/p/w500";

  MoviePopularModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = "$urlImage${json['poster_path']}",
        id = "${json['id']}";
}
