// lib/info_screen.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'golfer.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final golferBox = Hive.box<String>('golfers');

    return Scaffold(
      appBar: AppBar(title: Text('PGA Tour Top 10 Golfers')),
      body: FutureBuilder(
        future: golferBox.openBox(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final golfers = [
              Golfer('Scottie Scheffler', 461),
              Golfer('Rory McIlroy', 409),
              Golfer('Jon Rahm', 380),
              Golfer('Viktor Hovland', 349),
              Golfer('Patrick Cantlay', 242),
              Golfer('Xander Schauffele', 251),
              Golfer('Max Homa', 231),
              Golfer('Ryan Fitzpatrick', 246),
              Golfer('Brian Harman', 229),
              Golfer('Wyndham Clark', 222),
            ];

            return ListView.builder(
              itemCount: golfers.length,
              itemBuilder: (context, index) {
                final golfer = golfers[index];
                return ListTile(
                  title: Text(golfer.name),
                  subtitle: Text('Points: ${golfer.points}'),
                  onTap: () {
                    // Show points when golfer name is clicked
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Points: ${golfer.points}')),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
