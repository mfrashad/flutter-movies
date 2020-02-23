import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  var movie;

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    movie = data['movie'];

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'])
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 350,
                margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Image.network("https://image.tmdb.org/t/p/w500/${movie['poster_path']}")
              ),
            ),
            Text(movie['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard('~ min', Icons.timer),
                InfoCard(movie['release_date'].substring(0, 4), Icons.calendar_today),
                InfoCard('${movie['vote_average']}/10', Icons.star),
              ],
            ),
            Padding(         // Added from this line
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
              child: Text(movie['overview'],
                style: TextStyle(fontSize: 18)
              ),
            )
          ]
        ),
      )
    );
  }
}

class InfoCard extends StatelessWidget {
  String text = "";
  IconData icon;                      // Add this
  InfoCard(this.text, this.icon);     // Edit this

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Icon(icon,       // edit this
                size: 35
              ),
              SizedBox(height: 5),
              Text(text),
            ],
          )
      )
    );
  }
}

