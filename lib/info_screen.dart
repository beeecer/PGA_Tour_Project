import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pga_tour/models/golfer.dart';
import 'favorited_golfers_screen.dart'; // Import the screen to display favorited golfers

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Box<Golfer> golferBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    golferBox = await Hive.openBox<Golfer>('golfers');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PGA Tour Top 10 Golfers')),
      body: golferBox == null
          ? Center(child: CircularProgressIndicator())
          : buildGolfersList(),
    );
  }

  Widget buildGolfersList() {
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
            icon: Icon(
              golfer.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: golfer.isFavorite ? Colors.red : null, // Set the color conditionally
            ),
            onPressed: () {
              setState(() {
                golfer.isFavorite = !golfer.isFavorite;
                golferBox.put(golfer.name, golfer);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${golfer.name} ${golfer.isFavorite ? 'added to' : 'removed from'} favorites',
                    ),
                  ),
                );
              });
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
  }
}


