// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bowler_levels.dart';

class BowlerLevelMapper extends EnumMapper<BowlerLevel> {
  BowlerLevelMapper._();

  static BowlerLevelMapper? _instance;
  static BowlerLevelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BowlerLevelMapper._());
    }
    return _instance!;
  }

  static BowlerLevel fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BowlerLevel decode(dynamic value) {
    switch (value) {
      case r'novice':
        return BowlerLevel.novice;
      case r'beginner':
        return BowlerLevel.beginner;
      case r'intermediate':
        return BowlerLevel.intermediate;
      case r'proficient':
        return BowlerLevel.proficient;
      case r'advanced':
        return BowlerLevel.advanced;
      case r'pro':
        return BowlerLevel.pro;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BowlerLevel self) {
    switch (self) {
      case BowlerLevel.novice:
        return r'novice';
      case BowlerLevel.beginner:
        return r'beginner';
      case BowlerLevel.intermediate:
        return r'intermediate';
      case BowlerLevel.proficient:
        return r'proficient';
      case BowlerLevel.advanced:
        return r'advanced';
      case BowlerLevel.pro:
        return r'pro';
    }
  }
}

extension BowlerLevelMapperExtension on BowlerLevel {
  String toValue() {
    BowlerLevelMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BowlerLevel>(this) as String;
  }
}
