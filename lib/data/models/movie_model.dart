class MovieModel {
  final String title;
  final String year;
  final String poster;

  MovieModel({
    required this.title,
    required this.year,
    required this.poster,
  });

  factory MovieModel.deJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
    );
  }
}
