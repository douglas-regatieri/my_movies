class FilmeModel {
  final int id;
  final String title;
  final List<int> genre;
  final String? poster;
  final String? backdrop;
  final String overview;

  FilmeModel({
    required this.poster,
    required this.id,
    required this.title,
    required this.genre,
    this.backdrop,
    required this.overview,
  });

  factory FilmeModel.fromJson(Map<String, dynamic> json) {
    return FilmeModel(
      id: json["id"],
      title: json["title"],
      genre: List<int>.from(json["genre_ids"].map((a) => a)),
      poster: json["poster_path"],
      backdrop: json["backdrop_path"],
      overview: json["overview"],
    );
  }
}
