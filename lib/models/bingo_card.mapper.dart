// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bingo_card.dart';

class SpaceStateMapper extends EnumMapper<SpaceState> {
  SpaceStateMapper._();

  static SpaceStateMapper? _instance;
  static SpaceStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpaceStateMapper._());
    }
    return _instance!;
  }

  static SpaceState fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SpaceState decode(dynamic value) {
    switch (value) {
      case r'unmarked':
        return SpaceState.unmarked;
      case r'marked':
        return SpaceState.marked;
      case r'bonus':
        return SpaceState.bonus;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SpaceState self) {
    switch (self) {
      case SpaceState.unmarked:
        return r'unmarked';
      case SpaceState.marked:
        return r'marked';
      case SpaceState.bonus:
        return r'bonus';
    }
  }
}

extension SpaceStateMapperExtension on SpaceState {
  String toValue() {
    SpaceStateMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SpaceState>(this) as String;
  }
}

class BingoCardMapper extends ClassMapperBase<BingoCard> {
  BingoCardMapper._();

  static BingoCardMapper? _instance;
  static BingoCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BingoCardMapper._());
      SpaceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BingoCard';

  static int _$extent(BingoCard v) => v.extent;
  static const Field<BingoCard, int> _f$extent =
      Field('extent', _$extent, opt: true, def: 5);
  static List<Space> _$spaces(BingoCard v) => v.spaces;
  static const Field<BingoCard, List<Space>> _f$spaces =
      Field('spaces', _$spaces, opt: true, def: const []);

  @override
  final MappableFields<BingoCard> fields = const {
    #extent: _f$extent,
    #spaces: _f$spaces,
  };

  static BingoCard _instantiate(DecodingData data) {
    return BingoCard(extent: data.dec(_f$extent), spaces: data.dec(_f$spaces));
  }

  @override
  final Function instantiate = _instantiate;

  static BingoCard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BingoCard>(map);
  }

  static BingoCard fromJson(String json) {
    return ensureInitialized().decodeJson<BingoCard>(json);
  }
}

mixin BingoCardMappable {
  String toJson() {
    return BingoCardMapper.ensureInitialized()
        .encodeJson<BingoCard>(this as BingoCard);
  }

  Map<String, dynamic> toMap() {
    return BingoCardMapper.ensureInitialized()
        .encodeMap<BingoCard>(this as BingoCard);
  }

  BingoCardCopyWith<BingoCard, BingoCard, BingoCard> get copyWith =>
      _BingoCardCopyWithImpl<BingoCard, BingoCard>(
          this as BingoCard, $identity, $identity);
  @override
  String toString() {
    return BingoCardMapper.ensureInitialized()
        .stringifyValue(this as BingoCard);
  }

  @override
  bool operator ==(Object other) {
    return BingoCardMapper.ensureInitialized()
        .equalsValue(this as BingoCard, other);
  }

  @override
  int get hashCode {
    return BingoCardMapper.ensureInitialized().hashValue(this as BingoCard);
  }
}

extension BingoCardValueCopy<$R, $Out> on ObjectCopyWith<$R, BingoCard, $Out> {
  BingoCardCopyWith<$R, BingoCard, $Out> get $asBingoCard =>
      $base.as((v, t, t2) => _BingoCardCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BingoCardCopyWith<$R, $In extends BingoCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Space, SpaceCopyWith<$R, Space, Space>> get spaces;
  $R call({int? extent, List<Space>? spaces});
  BingoCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BingoCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BingoCard, $Out>
    implements BingoCardCopyWith<$R, BingoCard, $Out> {
  _BingoCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BingoCard> $mapper =
      BingoCardMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Space, SpaceCopyWith<$R, Space, Space>> get spaces =>
      ListCopyWith($value.spaces, (v, t) => v.copyWith.$chain(t),
          (v) => call(spaces: v));
  @override
  $R call({int? extent, List<Space>? spaces}) => $apply(FieldCopyWithData({
        if (extent != null) #extent: extent,
        if (spaces != null) #spaces: spaces
      }));
  @override
  BingoCard $make(CopyWithData data) => BingoCard(
      extent: data.get(#extent, or: $value.extent),
      spaces: data.get(#spaces, or: $value.spaces));

  @override
  BingoCardCopyWith<$R2, BingoCard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BingoCardCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SpaceMapper extends ClassMapperBase<Space> {
  SpaceMapper._();

  static SpaceMapper? _instance;
  static SpaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpaceMapper._());
      SpaceStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Space';

  static int _$index(Space v) => v.index;
  static const Field<Space, int> _f$index = Field('index', _$index);
  static SpaceState _$state(Space v) => v.state;
  static const Field<Space, SpaceState> _f$state =
      Field('state', _$state, opt: true, def: SpaceState.unmarked);
  static int _$pointsMultiplier(Space v) => v.pointsMultiplier;
  static const Field<Space, int> _f$pointsMultiplier =
      Field('pointsMultiplier', _$pointsMultiplier, opt: true, def: 1);

  @override
  final MappableFields<Space> fields = const {
    #index: _f$index,
    #state: _f$state,
    #pointsMultiplier: _f$pointsMultiplier,
  };

  static Space _instantiate(DecodingData data) {
    return Space(
        index: data.dec(_f$index),
        state: data.dec(_f$state),
        pointsMultiplier: data.dec(_f$pointsMultiplier));
  }

  @override
  final Function instantiate = _instantiate;

  static Space fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Space>(map);
  }

  static Space fromJson(String json) {
    return ensureInitialized().decodeJson<Space>(json);
  }
}

mixin SpaceMappable {
  String toJson() {
    return SpaceMapper.ensureInitialized().encodeJson<Space>(this as Space);
  }

  Map<String, dynamic> toMap() {
    return SpaceMapper.ensureInitialized().encodeMap<Space>(this as Space);
  }

  SpaceCopyWith<Space, Space, Space> get copyWith =>
      _SpaceCopyWithImpl<Space, Space>(this as Space, $identity, $identity);
  @override
  String toString() {
    return SpaceMapper.ensureInitialized().stringifyValue(this as Space);
  }

  @override
  bool operator ==(Object other) {
    return SpaceMapper.ensureInitialized().equalsValue(this as Space, other);
  }

  @override
  int get hashCode {
    return SpaceMapper.ensureInitialized().hashValue(this as Space);
  }
}

extension SpaceValueCopy<$R, $Out> on ObjectCopyWith<$R, Space, $Out> {
  SpaceCopyWith<$R, Space, $Out> get $asSpace =>
      $base.as((v, t, t2) => _SpaceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SpaceCopyWith<$R, $In extends Space, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? index, SpaceState? state, int? pointsMultiplier});
  SpaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SpaceCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Space, $Out>
    implements SpaceCopyWith<$R, Space, $Out> {
  _SpaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Space> $mapper = SpaceMapper.ensureInitialized();
  @override
  $R call({int? index, SpaceState? state, int? pointsMultiplier}) =>
      $apply(FieldCopyWithData({
        if (index != null) #index: index,
        if (state != null) #state: state,
        if (pointsMultiplier != null) #pointsMultiplier: pointsMultiplier
      }));
  @override
  Space $make(CopyWithData data) => Space(
      index: data.get(#index, or: $value.index),
      state: data.get(#state, or: $value.state),
      pointsMultiplier:
          data.get(#pointsMultiplier, or: $value.pointsMultiplier));

  @override
  SpaceCopyWith<$R2, Space, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SpaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
