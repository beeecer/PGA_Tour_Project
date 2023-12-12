import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pga_tour/models/golfer.dart';

class FavoritedGolfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final golferBox = Hive.box<Golfer>('golfers');

    // Get favorited golfers
    List<Golfer> favoritedGolfers = [];
    for (var i = 0; i < golferBox.length; i++) {
      var golfer = golferBox.getAt(i);
      if (golfer != null && golfer.isFavorite) {
        favoritedGolfers.add(golfer);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Favorited Golfers')),
      body: favoritedGolfers.isEmpty
          ? Center(child: Text('No favorited golfers yet'))
          : ListView.builder(
        itemCount: favoritedGolfers.length,
        itemBuilder: (context, index) {
          final golfer = favoritedGolfers[index];
          return ListTile(
            title: Text(golfer.name),
            subtitle: Text('Points: ${golfer.points}'),
          );
        },
      ),
    );
  }
}
