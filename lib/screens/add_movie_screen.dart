import 'package:flutter/material.dart';
import 'package:pmsn2020/database/movies_database.dart';
import 'package:pmsn2020/models/movie_dao.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  MoviesDatabase? moviesDB;
  var selectedDate = DateTime.timestamp();
  TextEditingController conTitle = TextEditingController();
  TextEditingController conTime = TextEditingController();
  TextEditingController conRelease = TextEditingController();

  @override
  void initState() {
    super.initState();
    moviesDB = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    MovieDAO? objM;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      objM = ModalRoute.of(context)!.settings.arguments as MovieDAO;
      conTitle.text = objM.title!;
      conTime.text = objM.time!;
      conRelease.text = objM.date_release!;
    }

    final txtTitle = TextFormField(
      controller: conTitle,
      decoration: InputDecoration(hintText: "Título"),
    );

    final txtTime = TextFormField(
      controller: conTime,
      decoration: InputDecoration(hintText: "Duración"),
    );

    final txtRelease = TextFormField(
      controller: conRelease,
      decoration: InputDecoration(hintText: "Fecha de lanzamiento"),
      onTap: () => _selectedDate(context),
      readOnly: true,
    );

    final btnSave = ElevatedButton(
      onPressed: () async {
        if (objM != null) {
          moviesDB?.update("movies", {
                'id_movie': objM.id_movie,
                'title': conTitle.text,
                'time': conTime.text,
                'date_release': conRelease.text,
              })
              .then((value) => Navigator.pop(context));
        } else {
          moviesDB?.insert("movies", {
                "id_movie": objM?.id_movie,
                "title": conTitle.text,
                "time": conTime.text,
                "date_release": conRelease.text,
              })
              .then((value) => Navigator.pop(context));
        }
      },
      child: Text('Guardar'),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Registro de película")),
      body: ListView(
        shrinkWrap: true,
        children: [txtTitle, txtTime, txtRelease, btnSave],
      ),
    );
  }

  Future _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        conRelease.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
