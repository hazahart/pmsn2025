import 'package:flutter/material.dart';
import 'package:pmsn2020/services/api_movies.dart';
import 'package:pmsn2020/widgets/item_movie_widget.dart';

class ListApiMovies extends StatefulWidget {
  const ListApiMovies({super.key});

  @override
  State<ListApiMovies> createState() => _ListApiMoviesState();
}

class _ListApiMoviesState extends State<ListApiMovies> {
  ApiMovies? apiMovies = ApiMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Movie DB'), centerTitle: true),
      body: FutureBuilder(
        future: apiMovies!.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              // child: GridView.builder(
              //   itemCount: snapshot.data!.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 10,
              //     childAspectRatio: 0.7
              //   ),
              //   itemBuilder: (context, index) {
              //     return ItemMovieWidget(apiMovieDao: snapshot.data![index]);
              //   },
              // ),
              child: CustomScrollView(
                slivers: [
                  SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return ItemMovieWidget(apiMovieDao: snapshot.data![index]);
                    },
                    itemCount: snapshot.data!.length,
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
