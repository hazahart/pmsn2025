class MovieDAO {
  int? id_movie;
  String? title;
  String? time;
  String? date_release;

  MovieDAO({this.id_movie, this.title, this.time, this.date_release});

  factory MovieDAO.fromMap(Map<String, dynamic> mapa) {
    return MovieDAO(
      id_movie: mapa['id_movie'],
      title: mapa['title'],
      time: mapa['time'],
      date_release: mapa['date_release'],
    );
  }
}
