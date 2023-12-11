// lib/models/golfer.dart
class Golfer {
  final String name;
  final int points;
  bool isFavorite;

  Golfer(this.name, this.points, {this.isFavorite = false});
}