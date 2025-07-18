// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game_state.dart';

class GameStateMapper extends ClassMapperBase<GameState> {
  GameStateMapper._();

  static GameStateMapper? _instance;
  static GameStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameStateMapper._());
      ChallengeMapper.ensureInitialized();
      SpaceMapper.ensureInitialized();
      ChallengeResultBaseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameState';

  static int _$game(GameState v) => v.game;
  static const Field<GameState, int> _f$game =
      Field('game', _$game, opt: true, def: 1);
  static int _$frame(GameState v) => v.frame;
  static const Field<GameState, int> _f$frame =
      Field('frame', _$frame, opt: true, def: 1);
  static Challenge? _$challenge(GameState v) => v.challenge;
  static const Field<GameState, Challenge> _f$challenge =
      Field('challenge', _$challenge, opt: true);
  static int _$points(GameState v) => v.points;
  static const Field<GameState, int> _f$points =
      Field('points', _$points, opt: true, def: 0);
  static List<Space> _$card(GameState v) => v.card;
  static const Field<GameState, List<Space>> _f$card =
      Field('card', _$card, opt: true, def: const []);
  static Map<int, List<ChallengeResultBase>> _$history(GameState v) =>
      v.history;
  static const Field<GameState, Map<int, List<ChallengeResultBase>>>
      _f$history = Field('history', _$history, opt: true, def: const {});

  @override
  final MappableFields<GameState> fields = const {
    #game: _f$game,
    #frame: _f$frame,
    #challenge: _f$challenge,
    #points: _f$points,
    #card: _f$card,
    #history: _f$history,
  };

  static GameState _instantiate(DecodingData data) {
    return GameState(
        game: data.dec(_f$game),
        frame: data.dec(_f$frame),
        challenge: data.dec(_f$challenge),
        points: data.dec(_f$points),
        card: data.dec(_f$card),
        history: data.dec(_f$history));
  }

  @override
  final Function instantiate = _instantiate;

  static GameState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameState>(map);
  }

  static GameState fromJson(String json) {
    return ensureInitialized().decodeJson<GameState>(json);
  }
}

mixin GameStateMappable {
  String toJson() {
    return GameStateMapper.ensureInitialized()
        .encodeJson<GameState>(this as GameState);
  }

  Map<String, dynamic> toMap() {
    return GameStateMapper.ensureInitialized()
        .encodeMap<GameState>(this as GameState);
  }

  GameStateCopyWith<GameState, GameState, GameState> get copyWith =>
      _GameStateCopyWithImpl<GameState, GameState>(
          this as GameState, $identity, $identity);
  @override
  String toString() {
    return GameStateMapper.ensureInitialized()
        .stringifyValue(this as GameState);
  }

  @override
  bool operator ==(Object other) {
    return GameStateMapper.ensureInitialized()
        .equalsValue(this as GameState, other);
  }

  @override
  int get hashCode {
    return GameStateMapper.ensureInitialized().hashValue(this as GameState);
  }
}

extension GameStateValueCopy<$R, $Out> on ObjectCopyWith<$R, GameState, $Out> {
  GameStateCopyWith<$R, GameState, $Out> get $asGameState =>
      $base.as((v, t, t2) => _GameStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameStateCopyWith<$R, $In extends GameState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ChallengeCopyWith<$R, Challenge, Challenge>? get challenge;
  ListCopyWith<$R, Space, SpaceCopyWith<$R, Space, Space>> get card;
  MapCopyWith<
      $R,
      int,
      List<ChallengeResultBase>,
      ObjectCopyWith<$R, List<ChallengeResultBase>,
          List<ChallengeResultBase>>> get history;
  $R call(
      {int? game,
      int? frame,
      Challenge? challenge,
      int? points,
      List<Space>? card,
      Map<int, List<ChallengeResultBase>>? history});
  GameStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameState, $Out>
    implements GameStateCopyWith<$R, GameState, $Out> {
  _GameStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameState> $mapper =
      GameStateMapper.ensureInitialized();
  @override
  ChallengeCopyWith<$R, Challenge, Challenge>? get challenge =>
      $value.challenge?.copyWith.$chain((v) => call(challenge: v));
  @override
  ListCopyWith<$R, Space, SpaceCopyWith<$R, Space, Space>> get card =>
      ListCopyWith(
          $value.card, (v, t) => v.copyWith.$chain(t), (v) => call(card: v));
  @override
  MapCopyWith<
      $R,
      int,
      List<ChallengeResultBase>,
      ObjectCopyWith<$R, List<ChallengeResultBase>,
          List<ChallengeResultBase>>> get history => MapCopyWith($value.history,
      (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(history: v));
  @override
  $R call(
          {int? game,
          int? frame,
          Object? challenge = $none,
          int? points,
          List<Space>? card,
          Map<int, List<ChallengeResultBase>>? history}) =>
      $apply(FieldCopyWithData({
        if (game != null) #game: game,
        if (frame != null) #frame: frame,
        if (challenge != $none) #challenge: challenge,
        if (points != null) #points: points,
        if (card != null) #card: card,
        if (history != null) #history: history
      }));
  @override
  GameState $make(CopyWithData data) => GameState(
      game: data.get(#game, or: $value.game),
      frame: data.get(#frame, or: $value.frame),
      challenge: data.get(#challenge, or: $value.challenge),
      points: data.get(#points, or: $value.points),
      card: data.get(#card, or: $value.card),
      history: data.get(#history, or: $value.history));

  @override
  GameStateCopyWith<$R2, GameState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ChallengeMapper extends ClassMapperBase<Challenge> {
  ChallengeMapper._();

  static ChallengeMapper? _instance;
  static ChallengeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChallengeMapper._());
      BowlingChallengeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Challenge';

  static int _$space(Challenge v) => v.space;
  static const Field<Challenge, int> _f$space = Field('space', _$space);
  static BowlingChallenge _$challenge(Challenge v) => v.challenge;
  static const Field<Challenge, BowlingChallenge> _f$challenge =
      Field('challenge', _$challenge);
  static int? _$strength(Challenge v) => v.strength;
  static const Field<Challenge, int> _f$strength =
      Field('strength', _$strength, opt: true);

  @override
  final MappableFields<Challenge> fields = const {
    #space: _f$space,
    #challenge: _f$challenge,
    #strength: _f$strength,
  };

  static Challenge _instantiate(DecodingData data) {
    return Challenge(
        space: data.dec(_f$space),
        challenge: data.dec(_f$challenge),
        strength: data.dec(_f$strength));
  }

  @override
  final Function instantiate = _instantiate;

  static Challenge fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Challenge>(map);
  }

  static Challenge fromJson(String json) {
    return ensureInitialized().decodeJson<Challenge>(json);
  }
}

mixin ChallengeMappable {
  String toJson() {
    return ChallengeMapper.ensureInitialized()
        .encodeJson<Challenge>(this as Challenge);
  }

  Map<String, dynamic> toMap() {
    return ChallengeMapper.ensureInitialized()
        .encodeMap<Challenge>(this as Challenge);
  }

  ChallengeCopyWith<Challenge, Challenge, Challenge> get copyWith =>
      _ChallengeCopyWithImpl<Challenge, Challenge>(
          this as Challenge, $identity, $identity);
  @override
  String toString() {
    return ChallengeMapper.ensureInitialized()
        .stringifyValue(this as Challenge);
  }

  @override
  bool operator ==(Object other) {
    return ChallengeMapper.ensureInitialized()
        .equalsValue(this as Challenge, other);
  }

  @override
  int get hashCode {
    return ChallengeMapper.ensureInitialized().hashValue(this as Challenge);
  }
}

extension ChallengeValueCopy<$R, $Out> on ObjectCopyWith<$R, Challenge, $Out> {
  ChallengeCopyWith<$R, Challenge, $Out> get $asChallenge =>
      $base.as((v, t, t2) => _ChallengeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChallengeCopyWith<$R, $In extends Challenge, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BowlingChallengeCopyWith<$R, BowlingChallenge, BowlingChallenge>
      get challenge;
  $R call({int? space, BowlingChallenge? challenge, int? strength});
  ChallengeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChallengeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Challenge, $Out>
    implements ChallengeCopyWith<$R, Challenge, $Out> {
  _ChallengeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Challenge> $mapper =
      ChallengeMapper.ensureInitialized();
  @override
  BowlingChallengeCopyWith<$R, BowlingChallenge, BowlingChallenge>
      get challenge =>
          $value.challenge.copyWith.$chain((v) => call(challenge: v));
  @override
  $R call(
          {int? space,
          BowlingChallenge? challenge,
          Object? strength = $none}) =>
      $apply(FieldCopyWithData({
        if (space != null) #space: space,
        if (challenge != null) #challenge: challenge,
        if (strength != $none) #strength: strength
      }));
  @override
  Challenge $make(CopyWithData data) => Challenge(
      space: data.get(#space, or: $value.space),
      challenge: data.get(#challenge, or: $value.challenge),
      strength: data.get(#strength, or: $value.strength));

  @override
  ChallengeCopyWith<$R2, Challenge, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChallengeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SpaceMapper extends ClassMapperBase<Space> {
  SpaceMapper._();

  static SpaceMapper? _instance;
  static SpaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SpaceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Space';

  static int _$index(Space v) => v.index;
  static const Field<Space, int> _f$index = Field('index', _$index);
  static bool _$isMarked(Space v) => v.isMarked;
  static const Field<Space, bool> _f$isMarked =
      Field('isMarked', _$isMarked, opt: true, def: false);

  @override
  final MappableFields<Space> fields = const {
    #index: _f$index,
    #isMarked: _f$isMarked,
  };

  static Space _instantiate(DecodingData data) {
    return Space(index: data.dec(_f$index), isMarked: data.dec(_f$isMarked));
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
  $R call({int? index, bool? isMarked});
  SpaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SpaceCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Space, $Out>
    implements SpaceCopyWith<$R, Space, $Out> {
  _SpaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Space> $mapper = SpaceMapper.ensureInitialized();
  @override
  $R call({int? index, bool? isMarked}) => $apply(FieldCopyWithData({
        if (index != null) #index: index,
        if (isMarked != null) #isMarked: isMarked
      }));
  @override
  Space $make(CopyWithData data) => Space(
      index: data.get(#index, or: $value.index),
      isMarked: data.get(#isMarked, or: $value.isMarked));

  @override
  SpaceCopyWith<$R2, Space, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SpaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
