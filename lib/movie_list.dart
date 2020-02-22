import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies;

  void getData() async {
    var data = await getJson();
    setState(() {
      movies = data['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: ListView.builder(
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) => FlatButton(
                    child: MovieCell(movies[i]),
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                  )),
            ),
          ],
        )
    );

  }
}

class MovieCell extends StatelessWidget {
  final movie;
  MovieCell(this.movie);

  final String image_url = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 5,
            child: InkWell(
              onTap: () {},
              child: Row(
                children: <Widget>[
                  MoviePoster(movie: movie, image_url: image_url),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movie['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                                movie['overview'],
                                maxLines: 5,
                                style: TextStyle(
                                    color: Colors.grey[500]
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key key,
    @required this.movie,
    @required this.image_url,
  }) : super(key: key);

  final movie;
  final String image_url;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: movie['id'],
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image_url + movie['poster_path'],
            ),
          ),
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
