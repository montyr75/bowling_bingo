// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bonus.dart';

class BonusMapper extends EnumMapper<Bonus> {
  BonusMapper._();

  static BonusMapper? _instance;
  static BonusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BonusMapper._());
    }
    return _instance!;
  }

  static Bonus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Bonus decode(dynamic value) {
    switch (value) {
      case r'freeSpace':
        return Bonus.freeSpace;
      case r'pointsMultiplier2':
        return Bonus.pointsMultiplier2;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Bonus self) {
    switch (self) {
      case Bonus.freeSpace:
        return r'freeSpace';
      case Bonus.pointsMultiplier2:
        return r'pointsMultiplier2';
    }
  }
}

extension BonusMapperExtension on Bonus {
  String toValue() {
    BonusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Bonus>(this) as String;
  }
}
