import 'package:dart_mappable/dart_mappable.dart';

part 'mystery.mapper.dart';

@MappableEnum()
enum Mystery {
  freeSpace(message: 'Free Space!'),
  pointsMultiplier2(message: 'Double Points!'),
  pointsMultiplierNegative(message: 'Negative Points!', isBonus: false);

  final String message;
  final bool isBonus;

  const Mystery({required this.message, this.isBonus = true});

  static Mystery getRandomMystery() {
    final mysteries = Mystery.values.toList()..shuffle();
    return mysteries.first;
  }
}