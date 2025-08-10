// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mystery.dart';

class MysteryMapper extends EnumMapper<Mystery> {
  MysteryMapper._();

  static MysteryMapper? _instance;
  static MysteryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MysteryMapper._());
    }
    return _instance!;
  }

  static Mystery fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Mystery decode(dynamic value) {
    switch (value) {
      case r'freeSpace':
        return Mystery.freeSpace;
      case r'pointsMultiplier2':
        return Mystery.pointsMultiplier2;
      case r'pointsMultiplierNegative':
        return Mystery.pointsMultiplierNegative;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Mystery self) {
    switch (self) {
      case Mystery.freeSpace:
        return r'freeSpace';
      case Mystery.pointsMultiplier2:
        return r'pointsMultiplier2';
      case Mystery.pointsMultiplierNegative:
        return r'pointsMultiplierNegative';
    }
  }
}

extension MysteryMapperExtension on Mystery {
  String toValue() {
    MysteryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Mystery>(this) as String;
  }
}
