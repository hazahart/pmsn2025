import 'package:flutter/material.dart';
import 'package:pmsn2020/database/movies_database.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  MoviesDatabase? moviesDB;

  @override
  void initState() {
    super.initState();
    moviesDB = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de películas')),
      body: FutureBuilder(
        future: moviesDB!.select(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something was wrong! ${snapshot.error}"),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = snapshot.data![index];
                  return Container(
                    height: 100,
                    color: Color(0xFF000000),
                    child: Text(movie.title! ?? "No title"),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                )
              );
            }
          }
        },
      ),
    );
  }
}
