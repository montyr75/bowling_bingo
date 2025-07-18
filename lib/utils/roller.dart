import "dart:math" as math;

import '../app_config.dart';
import '../utils/utils.dart' show IterableIntX;

final math.Random _random = math.Random(DateTime.now().millisecondsSinceEpoch);

int rand(int max) => _random.nextInt(max);

int roll(int sides) => rand(sides) + 1;

int rollDice(int qty, int sides, [int mod = 0]) {
  assert(qty >= 1 && sides >= 1);
  return List.generate(qty, (_) => roll(sides)).sum() + mod;
}

RollResult rollVerbose(int qty, int sides, [int mod = 0]) => DiceExpression(qty, sides, mod).rollVerbose();

bool rollPercent(int percentChance) => roll(100) <= percentChance;

class DiceExpression {
  static const String error = "*Roll Formula Error*";

  final int qty;
  final int sides;
  final int mod;

  const DiceExpression(this.qty, this.sides, [this.mod = 0]) : assert(qty >= 1 && sides >= 1);

  factory DiceExpression.fromFormula(String formula) {
    int sides;
    int qty = 0;
    int mod = 0;

    // strip out all spaces and convert to lowercase
    formula = formula.replaceAll(' ', '').toLowerCase();

    /*
    // RegExp broken out
    String re1 = r'(\d+)*';      // multi-digit integer (optional)
    String re2 = r'd';           // "d" (required, but not remembered in the match array)
    String re3 = r'([1-9]\d*)';  // multi-digit integer greater than 0 (required)
    String re4 = r'([-+]\d+)*';  // +/- and multi-digit integer (optional)
    RegExp exp = new RegExp(re1+re2+re3+re4, multiLine: false, caseSensitive: false);
    */

    final exp = RegExp(r"(\d+)*d([1-9]\d*)([-+]\d+)*", multiLine: false, caseSensitive: false);
    final matches = exp.firstMatch(formula);

    // if there are no matches, the string is an invalid expression
    if (matches == null) {
      log.error(error);
      throw Exception(error);
    }

    // DEBUG
//    if (matches != null) {
//        print("Group Count: ${matches.groupCount}\n");
//        for (int i = 0; i <= matches.groupCount; i++) {
//          print("$i: ${matches[i]}");
//        }
//  	}
//    else {
//      print("No RegExp match!");
//    }

    // process qty (default to 1 if not included or not valid)
    if (matches[1] != null) {
      final qtyInt = int.tryParse(matches[1]!);
      qty = qtyInt != null && qtyInt > 1 ? qtyInt : 1;
    } else {
      qty = 1;
    }

    // process die sides
    sides = int.parse(matches[2]!);

    // process modifier
    final modMatch = matches[3];
    if (modMatch != null) {
      if (modMatch.length > 1) {
        final sign = modMatch[0];
        int modInt = int.parse(modMatch.substring(1, modMatch.length));

        if (sign == "-") {
          modInt *= -1;
        }

        mod = modInt;
      }
    }

    return DiceExpression(qty, sides, mod);
  }

  int roll() => rollDice(qty, sides, mod);

  RollResult rollVerbose() {
    final rolls = List.generate(qty, (_) => rand(sides) + 1);
    final rollsTotal = rolls.sum();

    return RollResult(this, rolls, rollsTotal, rollsTotal + mod);
  }

  @override
  String toString() => "${qty}d$sides$modString";

  String get modString => (mod == 0) ? "" : " ${mod > 0 ? "+" : "-"} ${mod.abs()}";
}

class RollResult {
  final DiceExpression exp;

  final List<int> rolls;
  final int rollsTotal;
  final int total;

  RollResult(
    this.exp,
    this.rolls,
    this.rollsTotal,
    this.total,
  );

  @override
  String toString() => "$formulaString = $total";

  String toHTMLString() => "$formulaString = <b>$total</b>";

  String get formulaString => "${exp.qty}d${exp.sides} $rolls${exp.modString}";
}
