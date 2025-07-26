import 'package:dart_mappable/dart_mappable.dart';

part 'bonus.mapper.dart';

@MappableEnum()
enum Bonus {
  freeSpace('Enjoy your free bonus space!'),
  pointsMultiplier2('Double points for this space!');

  final String message;

  const Bonus(this.message);

  static Bonus getRandomBonus() {
    final bonuses = Bonus.values.toList()..shuffle();
    return bonuses.first;
  }
}