import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(title: Text('Lista de películas'), actions: []),
      body: FutureBuilder(
        future: moviesDB!.select(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something was wrong! ${snapshot.error}"),
            );
          } else {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data![index];
                        return Container(
                          height: 100,
                          child: Column(
                            children: [
                              Text(movie.title!),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      "/addmovie",
                                      arguments: movie,
                                    ).then((value) => setState(() {})),
                                    icon: Icon(Icons.edit),
                                  ),
                                  // Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () async {
                                      return showDialog(
                                        context: context,
                                        builder: (_) =>
                                            _buildAlert(movie.id_movie!),
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text("No entries"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addmovie');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAlert(int idMovie) {
    return CupertinoAlertDialog(
      title: Text("Mensaje de sistema"),
      content: Text("Borrar?"),
      actions: [
        TextButton(
          onPressed: () =>
              moviesDB!.delete("movies", idMovie).then((int value) {
                final msg;
                if (value > 0) {
                  msg = "Borrado";
                  setState(() {});
                } else {
                  msg = "No se elimino el registro";
                }
                final SnackBar snackBar = SnackBar(content: Text(msg));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              }),
          child: Text("Aceptar", style: TextStyle(color: Color(0xFF2781EA))),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancelar", style: TextStyle(color: Color(0xFFCC1100))),
        ),
      ],
    );
  }
}
