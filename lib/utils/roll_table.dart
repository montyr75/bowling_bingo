class RollRange {
  final int min;
  final int max;

  const RollRange(this.min, this.max);

  bool isHit(int roll) => roll >= min && roll <= max;
}

class RollTable<T> {
  final Map<RollRange, T> table;

  const RollTable(this.table);

  T? lookup(int roll) {
    for (final RollRange rng in table.keys) {
      if (rng.isHit(roll)) {
        return table[rng];
      }
    }

    return null;
  }
}