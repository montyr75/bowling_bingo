// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bowling_challenges.dart';

class BowlingHitMapper extends EnumMapper<BowlingHit> {
  BowlingHitMapper._();

  static BowlingHitMapper? _instance;
  static BowlingHitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BowlingHitMapper._());
    }
    return _instance!;
  }

  static BowlingHit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BowlingHit decode(dynamic value) {
    switch (value) {
      case r'strike':
        return BowlingHit.strike;
      case r'spare':
        return BowlingHit.spare;
      case r'min1':
        return BowlingHit.min1;
      case r'min':
        return BowlingHit.min;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BowlingHit self) {
    switch (self) {
      case BowlingHit.strike:
        return r'strike';
      case BowlingHit.spare:
        return r'spare';
      case BowlingHit.min1:
        return r'min1';
      case BowlingHit.min:
        return r'min';
    }
  }
}

extension BowlingHitMapperExtension on BowlingHit {
  String toValue() {
    BowlingHitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BowlingHit>(this) as String;
  }
}

class BowlingChallengeMapper extends ClassMapperBase<BowlingChallenge> {
  BowlingChallengeMapper._();

  static BowlingChallengeMapper? _instance;
  static BowlingChallengeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BowlingChallengeMapper._());
      TenthFrameBowlingChallengeMapper.ensureInitialized();
      BowlingHitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BowlingChallenge';

  static int _$level(BowlingChallenge v) => v.level;
  static const Field<BowlingChallenge, int> _f$level = Field('level', _$level);
  static bool _$isVariable(BowlingChallenge v) => v.isVariable;
  static const Field<BowlingChallenge, bool> _f$isVariable =
      Field('isVariable', _$isVariable, opt: true, def: false);
  static BowlingHit? _$firstThrow(BowlingChallenge v) => v.firstThrow;
  static const Field<BowlingChallenge, BowlingHit> _f$firstThrow =
      Field('firstThrow', _$firstThrow, opt: true);
  static BowlingHit? _$secondThrow(BowlingChallenge v) => v.secondThrow;
  static const Field<BowlingChallenge, BowlingHit> _f$secondThrow =
      Field('secondThrow', _$secondThrow, opt: true);
  static BowlingHit? _$frameTotal(BowlingChallenge v) => v.frameTotal;
  static const Field<BowlingChallenge, BowlingHit> _f$frameTotal =
      Field('frameTotal', _$frameTotal, opt: true);
  static String _$description(BowlingChallenge v) => v.description;
  static const Field<BowlingChallenge, String> _f$description =
      Field('description', _$description);

  @override
  final MappableFields<BowlingChallenge> fields = const {
    #level: _f$level,
    #isVariable: _f$isVariable,
    #firstThrow: _f$firstThrow,
    #secondThrow: _f$secondThrow,
    #frameTotal: _f$frameTotal,
    #description: _f$description,
  };

  static BowlingChallenge _instantiate(DecodingData data) {
    return BowlingChallenge(
        level: data.dec(_f$level),
        isVariable: data.dec(_f$isVariable),
        firstThrow: data.dec(_f$firstThrow),
        secondThrow: data.dec(_f$secondThrow),
        frameTotal: data.dec(_f$frameTotal),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static BowlingChallenge fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BowlingChallenge>(map);
  }

  static BowlingChallenge fromJson(String json) {
    return ensureInitialized().decodeJson<BowlingChallenge>(json);
  }
}

mixin BowlingChallengeMappable {
  String toJson() {
    return BowlingChallengeMapper.ensureInitialized()
        .encodeJson<BowlingChallenge>(this as BowlingChallenge);
  }

  Map<String, dynamic> toMap() {
    return BowlingChallengeMapper.ensureInitialized()
        .encodeMap<BowlingChallenge>(this as BowlingChallenge);
  }

  BowlingChallengeCopyWith<BowlingChallenge, BowlingChallenge, BowlingChallenge>
      get copyWith =>
          _BowlingChallengeCopyWithImpl<BowlingChallenge, BowlingChallenge>(
              this as BowlingChallenge, $identity, $identity);
  @override
  String toString() {
    return BowlingChallengeMapper.ensureInitialized()
        .stringifyValue(this as BowlingChallenge);
  }

  @override
  bool operator ==(Object other) {
    return BowlingChallengeMapper.ensureInitialized()
        .equalsValue(this as BowlingChallenge, other);
  }

  @override
  int get hashCode {
    return BowlingChallengeMapper.ensureInitialized()
        .hashValue(this as BowlingChallenge);
  }
}

extension BowlingChallengeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BowlingChallenge, $Out> {
  BowlingChallengeCopyWith<$R, BowlingChallenge, $Out>
      get $asBowlingChallenge => $base
          .as((v, t, t2) => _BowlingChallengeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BowlingChallengeCopyWith<$R, $In extends BowlingChallenge, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? level,
      bool? isVariable,
      BowlingHit? firstThrow,
      BowlingHit? secondThrow,
      BowlingHit? frameTotal,
      String? description});
  BowlingChallengeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BowlingChallengeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BowlingChallenge, $Out>
    implements BowlingChallengeCopyWith<$R, BowlingChallenge, $Out> {
  _BowlingChallengeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BowlingChallenge> $mapper =
      BowlingChallengeMapper.ensureInitialized();
  @override
  $R call(
          {int? level,
          bool? isVariable,
          Object? firstThrow = $none,
          Object? secondThrow = $none,
          Object? frameTotal = $none,
          String? description}) =>
      $apply(FieldCopyWithData({
        if (level != null) #level: level,
        if (isVariable != null) #isVariable: isVariable,
        if (firstThrow != $none) #firstThrow: firstThrow,
        if (secondThrow != $none) #secondThrow: secondThrow,
        if (frameTotal != $none) #frameTotal: frameTotal,
        if (description != null) #description: description
      }));
  @override
  BowlingChallenge $make(CopyWithData data) => BowlingChallenge(
      level: data.get(#level, or: $value.level),
      isVariable: data.get(#isVariable, or: $value.isVariable),
      firstThrow: data.get(#firstThrow, or: $value.firstThrow),
      secondThrow: data.get(#secondThrow, or: $value.secondThrow),
      frameTotal: data.get(#frameTotal, or: $value.frameTotal),
      description: data.get(#description, or: $value.description));

  @override
  BowlingChallengeCopyWith<$R2, BowlingChallenge, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BowlingChallengeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TenthFrameBowlingChallengeMapper
    extends ClassMapperBase<TenthFrameBowlingChallenge> {
  TenthFrameBowlingChallengeMapper._();

  static TenthFrameBowlingChallengeMapper? _instance;
  static TenthFrameBowlingChallengeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TenthFrameBowlingChallengeMapper._());
      BowlingChallengeMapper.ensureInitialized();
      BowlingHitMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TenthFrameBowlingChallenge';

  static int _$level(TenthFrameBowlingChallenge v) => v.level;
  static const Field<TenthFrameBowlingChallenge, int> _f$level =
      Field('level', _$level);
  static bool _$isVariable(TenthFrameBowlingChallenge v) => v.isVariable;
  static const Field<TenthFrameBowlingChallenge, bool> _f$isVariable =
      Field('isVariable', _$isVariable, opt: true, def: false);
  static BowlingHit? _$firstThrow(TenthFrameBowlingChallenge v) => v.firstThrow;
  static const Field<TenthFrameBowlingChallenge, BowlingHit> _f$firstThrow =
      Field('firstThrow', _$firstThrow, opt: true);
  static BowlingHit? _$secondThrow(TenthFrameBowlingChallenge v) =>
      v.secondThrow;
  static const Field<TenthFrameBowlingChallenge, BowlingHit> _f$secondThrow =
      Field('secondThrow', _$secondThrow, opt: true);
  static BowlingHit? _$thirdThrow(TenthFrameBowlingChallenge v) => v.thirdThrow;
  static const Field<TenthFrameBowlingChallenge, BowlingHit> _f$thirdThrow =
      Field('thirdThrow', _$thirdThrow, opt: true);
  static BowlingHit? _$frameTotal(TenthFrameBowlingChallenge v) => v.frameTotal;
  static const Field<TenthFrameBowlingChallenge, BowlingHit> _f$frameTotal =
      Field('frameTotal', _$frameTotal, opt: true);
  static String _$description(TenthFrameBowlingChallenge v) => v.description;
  static const Field<TenthFrameBowlingChallenge, String> _f$description =
      Field('description', _$description);

  @override
  final MappableFields<TenthFrameBowlingChallenge> fields = const {
    #level: _f$level,
    #isVariable: _f$isVariable,
    #firstThrow: _f$firstThrow,
    #secondThrow: _f$secondThrow,
    #thirdThrow: _f$thirdThrow,
    #frameTotal: _f$frameTotal,
    #description: _f$description,
  };

  static TenthFrameBowlingChallenge _instantiate(DecodingData data) {
    return TenthFrameBowlingChallenge(
        level: data.dec(_f$level),
        isVariable: data.dec(_f$isVariable),
        firstThrow: data.dec(_f$firstThrow),
        secondThrow: data.dec(_f$secondThrow),
        thirdThrow: data.dec(_f$thirdThrow),
        frameTotal: data.dec(_f$frameTotal),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static TenthFrameBowlingChallenge fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TenthFrameBowlingChallenge>(map);
  }

  static TenthFrameBowlingChallenge fromJson(String json) {
    return ensureInitialized().decodeJson<TenthFrameBowlingChallenge>(json);
  }
}

mixin TenthFrameBowlingChallengeMappable {
  String toJson() {
    return TenthFrameBowlingChallengeMapper.ensureInitialized()
        .encodeJson<TenthFrameBowlingChallenge>(
            this as TenthFrameBowlingChallenge);
  }

  Map<String, dynamic> toMap() {
    return TenthFrameBowlingChallengeMapper.ensureInitialized()
        .encodeMap<TenthFrameBowlingChallenge>(
            this as TenthFrameBowlingChallenge);
  }

  TenthFrameBowlingChallengeCopyWith<TenthFrameBowlingChallenge,
          TenthFrameBowlingChallenge, TenthFrameBowlingChallenge>
      get copyWith => _TenthFrameBowlingChallengeCopyWithImpl<
              TenthFrameBowlingChallenge, TenthFrameBowlingChallenge>(
          this as TenthFrameBowlingChallenge, $identity, $identity);
  @override
  String toString() {
    return TenthFrameBowlingChallengeMapper.ensureInitialized()
        .stringifyValue(this as TenthFrameBowlingChallenge);
  }

  @override
  bool operator ==(Object other) {
    return TenthFrameBowlingChallengeMapper.ensureInitialized()
        .equalsValue(this as TenthFrameBowlingChallenge, other);
  }

  @override
  int get hashCode {
    return TenthFrameBowlingChallengeMapper.ensureInitialized()
        .hashValue(this as TenthFrameBowlingChallenge);
  }
}

extension TenthFrameBowlingChallengeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TenthFrameBowlingChallenge, $Out> {
  TenthFrameBowlingChallengeCopyWith<$R, TenthFrameBowlingChallenge, $Out>
      get $asTenthFrameBowlingChallenge => $base.as((v, t, t2) =>
          _TenthFrameBowlingChallengeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TenthFrameBowlingChallengeCopyWith<
    $R,
    $In extends TenthFrameBowlingChallenge,
    $Out> implements BowlingChallengeCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {int? level,
      bool? isVariable,
      BowlingHit? firstThrow,
      BowlingHit? secondThrow,
      BowlingHit? thirdThrow,
      BowlingHit? frameTotal,
      String? description});
  TenthFrameBowlingChallengeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TenthFrameBowlingChallengeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TenthFrameBowlingChallenge, $Out>
    implements
        TenthFrameBowlingChallengeCopyWith<$R, TenthFrameBowlingChallenge,
            $Out> {
  _TenthFrameBowlingChallengeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TenthFrameBowlingChallenge> $mapper =
      TenthFrameBowlingChallengeMapper.ensureInitialized();
  @override
  $R call(
          {int? level,
          bool? isVariable,
          Object? firstThrow = $none,
          Object? secondThrow = $none,
          Object? thirdThrow = $none,
          Object? frameTotal = $none,
          String? description}) =>
      $apply(FieldCopyWithData({
        if (level != null) #level: level,
        if (isVariable != null) #isVariable: isVariable,
        if (firstThrow != $none) #firstThrow: firstThrow,
        if (secondThrow != $none) #secondThrow: secondThrow,
        if (thirdThrow != $none) #thirdThrow: thirdThrow,
        if (frameTotal != $none) #frameTotal: frameTotal,
        if (description != null) #description: description
      }));
  @override
  TenthFrameBowlingChallenge $make(CopyWithData data) =>
      TenthFrameBowlingChallenge(
          level: data.get(#level, or: $value.level),
          isVariable: data.get(#isVariable, or: $value.isVariable),
          firstThrow: data.get(#firstThrow, or: $value.firstThrow),
          secondThrow: data.get(#secondThrow, or: $value.secondThrow),
          thirdThrow: data.get(#thirdThrow, or: $value.thirdThrow),
          frameTotal: data.get(#frameTotal, or: $value.frameTotal),
          description: data.get(#description, or: $value.description));

  @override
  TenthFrameBowlingChallengeCopyWith<$R2, TenthFrameBowlingChallenge, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TenthFrameBowlingChallengeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
