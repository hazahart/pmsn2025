import 'package:dio/dio.dart';
import 'package:pmsn2020/models/api_movie_dao.dart';

class ApiMovies {

  final dio = Dio();
  final String URL = "https://api.themoviedb.org/3/movie/popular?api_key=8013385aa7bf10b3b46b16239c22e22c";

  Future<List<dynamic>> getMovies() async {
    final response = await dio.get(URL);
    final result = response.data;
    return result.map((movie) => ApiMovieDao.fromMap(movie as Map<String, dynamic>)).toList();
  }
}