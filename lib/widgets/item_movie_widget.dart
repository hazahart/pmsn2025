import 'package:flutter/material.dart';
import 'package:pmsn2020/models/api_movie_dao.dart';

class ItemMovieWidget extends StatelessWidget {
  ItemMovieWidget({super.key, required this.apiMovieDao});

  ApiMovieDao apiMovieDao;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: FadeInImage(placeholder: AssetImage('assets/loading-cat.gif'), image: NetworkImage("https://image.tmdb.org/t/p/original/${apiMovieDao.posterPath}")),
    );
  }
}