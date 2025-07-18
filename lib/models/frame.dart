import 'package:dart_mappable/dart_mappable.dart';

import 'package:dartx/dartx.dart';

part 'frame.mapper.dart';

@MappableClass()
class Frame with FrameMappable {
  final int? firstThrow;
  final int? secondThrow;
  final int? score;

  const Frame({
    this.firstThrow,
    this.secondThrow,
    this.score,
  });

  Frame clearThrowsAfter(int ballThrow) => Frame(
    firstThrow: ballThrow >= 1 ? firstThrow : null,
    secondThrow: ballThrow >= 2 ? secondThrow : null,
    score: score,
  );

  bool get isStrike => (firstThrow ?? 0) == 10;
  bool get isSpare => !isStrike && (firstThrow ?? 0) + (secondThrow ?? 0) == 10;
  bool get isOpen => !isStrike && !isSpare;
  bool get isComplete => isStrike || firstThrow != null && secondThrow != null;
  List<int?> get throws => [firstThrow, secondThrow];

  int? get currentThrow {
    if (firstThrow == null) {
      return 1;
    }

    if (secondThrow == null && !isStrike) {
      return 2;
    }

    return null;
  }

  @override
  String toString() {
    return 'Frame{firstThrow: $firstThrow, secondThrow: $secondThrow}';
  }
}

@MappableClass()
class TenthFrame extends Frame with TenthFrameMappable {
  final int? thirdThrow;

  const TenthFrame({
    super.firstThrow,
    super.secondThrow,
    this.thirdThrow,
    super.score,
  });

  @override
  TenthFrame clearThrowsAfter(int ballThrow) => TenthFrame(
    firstThrow: ballThrow >= 1 ? firstThrow : null,
    secondThrow: ballThrow >= 2 ? secondThrow : null,
    thirdThrow: ballThrow >= 3 ? thirdThrow : null,
    score: score,
  );

  bool get hasThirdThrow => thirdThrow != null;
  bool get requiresThirdThrow => isStrike || isSpare || secondThrow == 10;
  bool get hasSpare => isSpare || isSpare2;
  bool get isSpare2 => isStrike && (secondThrow ?? 0) + (thirdThrow ?? 0) == 10;
  bool get hasStrike => strikeCount > 0;

  @override
  bool get isComplete => firstThrow != null && secondThrow != null && (!requiresThirdThrow || thirdThrow != null);

  @override
  List<int?> get throws => [...super.throws, thirdThrow];

  int get strikeCount {
    return [
      isStrike,
      secondThrow == 10,
      thirdThrow == 10,
    ].count((value) => value);
  }

  @override
  int? get currentThrow {
    if (firstThrow == null) {
      return 1;
    }

    if (secondThrow == null) {
      return 2;
    }

    if (thirdThrow == null && requiresThirdThrow) {
      return 3;
    }

    return null;
  }

  @override
  String toString() {
    return 'Frame{firstThrow: $firstThrow, secondThrow: $secondThrow, thirdThrow: $thirdThrow}';
  }
}