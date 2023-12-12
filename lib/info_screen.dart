import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pga_tour/models/golfer.dart';
import 'favorited_golfers_screen.dart'; // Import the screen to display favorited golfers

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final golferBox = Hive.box<Golfer>('golfers');

    return Scaffold(
      appBar: AppBar(title: Text('PGA Tour Top 10 Golfers')),
      body: FutureBuilder(
        future: Hive.openBox<Golfer>('golfers'),
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

            for (var i = 0; i < golfers.length; i++) {
              var golfer = golfers[i];
              var savedGolfer = golferBox.get(golfer.name);
              if (savedGolfer != null && savedGolfer is Golfer) {
                golfers[i].isFavorite = savedGolfer.isFavorite;
              }
            }

            return ListView.builder(
              itemCount: golfers.length,
              itemBuilder: (context, index) {
                final golfer = golfers[index];
                return ListTile(
                  title: Text(golfer.name),
                  subtitle: Text('Points: ${golfer.points}'),
                  trailing: IconButton(
                    icon: golfer.isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      golfer.isFavorite = !golfer.isFavorite;
                      golferBox.put(golfer.name, golfer);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${golfer.name} ${golfer.isFavorite ? 'added to' : 'removed from'} favorites'),
                        ),
                      );
                    },
                  ),
                  onTap: () {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritedGolfersScreen()),
          );
        },
        child: Icon(Icons.star),
      ),
    );
  }
}

