import 'package:flutter/material.dart';

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
            MovieCard()
          ],
        )
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
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
              child: Image.network('https://image.tmdb.org/t/p/w500/yJdeWaVXa2se9agI6B4mQunVYkB.jpg')
            ),
            Expanded(
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Ip Man 4: The Finale',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Text('Following the death of his wife, Ip Man travels to San Francisco to ease tensions between the local kung fu masters and his star student, Bruce Lee, while searching for a better future for his son.'))
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

