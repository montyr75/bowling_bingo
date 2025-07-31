// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bowling_game.dart';

class BowlingGameMapper extends ClassMapperBase<BowlingGame> {
  BowlingGameMapper._();

  static BowlingGameMapper? _instance;
  static BowlingGameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BowlingGameMapper._());
      ChallengeResultBaseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BowlingGame';

  static List<ChallengeResultBase> _$results(BowlingGame v) => v.results;
  static const Field<BowlingGame, List<ChallengeResultBase>> _f$results =
      Field('results', _$results, opt: true, def: const []);

  @override
  final MappableFields<BowlingGame> fields = const {
    #results: _f$results,
  };

  static BowlingGame _instantiate(DecodingData data) {
    return BowlingGame(results: data.dec(_f$results));
  }

  @override
  final Function instantiate = _instantiate;

  static BowlingGame fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BowlingGame>(map);
  }

  static BowlingGame fromJson(String json) {
    return ensureInitialized().decodeJson<BowlingGame>(json);
  }
}

mixin BowlingGameMappable {
  String toJson() {
    return BowlingGameMapper.ensureInitialized()
        .encodeJson<BowlingGame>(this as BowlingGame);
  }

  Map<String, dynamic> toMap() {
    return BowlingGameMapper.ensureInitialized()
        .encodeMap<BowlingGame>(this as BowlingGame);
  }

  BowlingGameCopyWith<BowlingGame, BowlingGame, BowlingGame> get copyWith =>
      _BowlingGameCopyWithImpl<BowlingGame, BowlingGame>(
          this as BowlingGame, $identity, $identity);
  @override
  String toString() {
    return BowlingGameMapper.ensureInitialized()
        .stringifyValue(this as BowlingGame);
  }

  @override
  bool operator ==(Object other) {
    return BowlingGameMapper.ensureInitialized()
        .equalsValue(this as BowlingGame, other);
  }

  @override
  int get hashCode {
    return BowlingGameMapper.ensureInitialized().hashValue(this as BowlingGame);
  }
}

extension BowlingGameValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BowlingGame, $Out> {
  BowlingGameCopyWith<$R, BowlingGame, $Out> get $asBowlingGame =>
      $base.as((v, t, t2) => _BowlingGameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BowlingGameCopyWith<$R, $In extends BowlingGame, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ChallengeResultBase,
      ObjectCopyWith<$R, ChallengeResultBase, ChallengeResultBase>> get results;
  $R call({List<ChallengeResultBase>? results});
  BowlingGameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BowlingGameCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BowlingGame, $Out>
    implements BowlingGameCopyWith<$R, BowlingGame, $Out> {
  _BowlingGameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BowlingGame> $mapper =
      BowlingGameMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ChallengeResultBase,
          ObjectCopyWith<$R, ChallengeResultBase, ChallengeResultBase>>
      get results => ListCopyWith($value.results,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(results: v));
  @override
  $R call({List<ChallengeResultBase>? results}) =>
      $apply(FieldCopyWithData({if (results != null) #results: results}));
  @override
  BowlingGame $make(CopyWithData data) =>
      BowlingGame(results: data.get(#results, or: $value.results));

  @override
  BowlingGameCopyWith<$R2, BowlingGame, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BowlingGameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
