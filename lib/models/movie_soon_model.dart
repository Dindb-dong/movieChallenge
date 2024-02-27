class MovieSoonModel {
  final String title, posterPath, id;
  static String urlImage = "https://image.tmdb.org/t/p/w500";

  MovieSoonModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = "$urlImage${json['poster_path']}",
        id = "${json['id']}";
}
