import 'package:dart_mappable/dart_mappable.dart';

import '../utils/roller.dart';
import '../utils/utils.dart';

part 'mystery.mapper.dart';

@MappableEnum()
enum Mystery {
  freeSpace(message: 'Free Space!'),
  pointsMultiplier2(message: 'Double Points!'),
  pointsMultiplierNegative(message: 'Negative Points!', isBonus: false),
  loseSpace(message: 'Lose a Space!', isBonus: false);

  final String message;
  final bool isBonus;

  const Mystery({required this.message, this.isBonus = true});

  static Mystery getRandomMystery({int failureRate = 0}) {
    final oddsOfBonus = 50 + (failureRate ~/ 2).maxOf<int>(25);

    if (rollPercent(oddsOfBonus)) {
      return getRandomBonus();
    } else {
      return getRandomPenalty();
    }
  }

  static Mystery getRandomBonus() {
    final mysteries = Mystery.values.where((value) => value.isBonus).toList()..shuffle();
    return mysteries.first;
  }

  static Mystery getRandomPenalty() {
    final mysteries = Mystery.values.where((value) => !value.isBonus).toList()..shuffle();
    return mysteries.first;
  }
}