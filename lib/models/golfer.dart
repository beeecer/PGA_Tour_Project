// lib/models/golfer.dart
import 'package:hive/hive.dart';

part 'golfer.g.dart';



@HiveType(typeId: 0)
class Golfer {

  @HiveField(0)
  late String name;
  @HiveField(1)
  late int points;
  @HiveField(2)
  late bool isFavorite;

  Golfer(this.name, this.points, {this.isFavorite = false});
}