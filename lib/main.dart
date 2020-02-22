import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Movies'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Discover",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              MovieList(),                 // Add this
//              Expanded(                  // Remove this
//                child: ListView.builder(
//                    itemCount: 6,
//                    itemBuilder: (context, i) => MovieCard()),
//              ),
            ],
          )
      ),
    );
  }
}

class MovieList extends StatefulWidget {

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies;     // Add this

  Future<void> getData() async {      //Add this function
    try {
      var data = await getJson();
      setState(() {
        movies = data['results'];
      });
    }
    catch (error) { print(error);}
  }                          //Until here

  @override
  Widget build(BuildContext context) {
    getData();
    return Expanded(
      child: ListView.builder(
          itemCount: movies == null ? 0 : movies.length,      // Edit this
          itemBuilder: (context, i) => MovieCard(movies[i])),   //Edit this
    );
  }
}


class MovieCard extends StatelessWidget {
  final movie;  // Add this
  MovieCard(this.movie); // Add this

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Container(
                height: 180,
                child: Image.network('https://image.tmdb.org/t/p/w500/${movie['poster_path']}')
            ),
            Expanded(
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(movie['title'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text(movie['release_date'].toString()),
                    SizedBox(height: 10),
                    Expanded(child: Text(movie['overview']))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var url =
      'http://api.themoviedb.org/3/discover/movie?api_key=20a3f47c1f9a22b518bf93d335169cca';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

