// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'challenge_result.dart';

class ChallengeResultBaseMapper extends ClassMapperBase<ChallengeResultBase> {
  ChallengeResultBaseMapper._();

  static ChallengeResultBaseMapper? _instance;
  static ChallengeResultBaseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChallengeResultBaseMapper._());
      ChallengeResultMapper.ensureInitialized();
      FinalChallengeResultMapper.ensureInitialized();
      FrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChallengeResultBase';

  static int _$game(ChallengeResultBase v) => v.game;
  static const Field<ChallengeResultBase, int> _f$game = Field('game', _$game);
  static int _$frame(ChallengeResultBase v) => v.frame;
  static const Field<ChallengeResultBase, int> _f$frame =
      Field('frame', _$frame);
  static int? _$strength(ChallengeResultBase v) => v.strength;
  static const Field<ChallengeResultBase, int> _f$strength =
      Field('strength', _$strength, opt: true);
  static Frame _$frameData(ChallengeResultBase v) => v.frameData;
  static const Field<ChallengeResultBase, Frame> _f$frameData =
      Field('frameData', _$frameData);
  static bool _$isSuccess(ChallengeResultBase v) => v.isSuccess;
  static const Field<ChallengeResultBase, bool> _f$isSuccess =
      Field('isSuccess', _$isSuccess, opt: true, def: false);

  @override
  final MappableFields<ChallengeResultBase> fields = const {
    #game: _f$game,
    #frame: _f$frame,
    #strength: _f$strength,
    #frameData: _f$frameData,
    #isSuccess: _f$isSuccess,
  };

  static ChallengeResultBase _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('ChallengeResultBase');
  }

  @override
  final Function instantiate = _instantiate;

  static ChallengeResultBase fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChallengeResultBase>(map);
  }

  static ChallengeResultBase fromJson(String json) {
    return ensureInitialized().decodeJson<ChallengeResultBase>(json);
  }
}

mixin ChallengeResultBaseMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ChallengeResultBaseCopyWith<ChallengeResultBase, ChallengeResultBase,
      ChallengeResultBase> get copyWith;
}

abstract class ChallengeResultBaseCopyWith<$R, $In extends ChallengeResultBase,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  FrameCopyWith<$R, Frame, Frame> get frameData;
  $R call(
      {int? game,
      int? frame,
      int? strength,
      Frame? frameData,
      bool? isSuccess});
  ChallengeResultBaseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class ChallengeResultMapper extends ClassMapperBase<ChallengeResult> {
  ChallengeResultMapper._();

  static ChallengeResultMapper? _instance;
  static ChallengeResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChallengeResultMapper._());
      ChallengeResultBaseMapper.ensureInitialized();
      BowlingChallengeMapper.ensureInitialized();
      FrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChallengeResult';

  static int _$game(ChallengeResult v) => v.game;
  static const Field<ChallengeResult, int> _f$game = Field('game', _$game);
  static int _$frame(ChallengeResult v) => v.frame;
  static const Field<ChallengeResult, int> _f$frame = Field('frame', _$frame);
  static int? _$strength(ChallengeResult v) => v.strength;
  static const Field<ChallengeResult, int> _f$strength =
      Field('strength', _$strength, opt: true);
  static BowlingChallenge _$challenge(ChallengeResult v) => v.challenge;
  static const Field<ChallengeResult, BowlingChallenge> _f$challenge =
      Field('challenge', _$challenge);
  static Frame _$frameData(ChallengeResult v) => v.frameData;
  static const Field<ChallengeResult, Frame> _f$frameData =
      Field('frameData', _$frameData);
  static bool _$isSuccess(ChallengeResult v) => v.isSuccess;
  static const Field<ChallengeResult, bool> _f$isSuccess =
      Field('isSuccess', _$isSuccess, opt: true, def: false);

  @override
  final MappableFields<ChallengeResult> fields = const {
    #game: _f$game,
    #frame: _f$frame,
    #strength: _f$strength,
    #challenge: _f$challenge,
    #frameData: _f$frameData,
    #isSuccess: _f$isSuccess,
  };

  static ChallengeResult _instantiate(DecodingData data) {
    return ChallengeResult(
        game: data.dec(_f$game),
        frame: data.dec(_f$frame),
        strength: data.dec(_f$strength),
        challenge: data.dec(_f$challenge),
        frameData: data.dec(_f$frameData),
        isSuccess: data.dec(_f$isSuccess));
  }

  @override
  final Function instantiate = _instantiate;

  static ChallengeResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChallengeResult>(map);
  }

  static ChallengeResult fromJson(String json) {
    return ensureInitialized().decodeJson<ChallengeResult>(json);
  }
}

mixin ChallengeResultMappable {
  String toJson() {
    return ChallengeResultMapper.ensureInitialized()
        .encodeJson<ChallengeResult>(this as ChallengeResult);
  }

  Map<String, dynamic> toMap() {
    return ChallengeResultMapper.ensureInitialized()
        .encodeMap<ChallengeResult>(this as ChallengeResult);
  }

  ChallengeResultCopyWith<ChallengeResult, ChallengeResult, ChallengeResult>
      get copyWith =>
          _ChallengeResultCopyWithImpl<ChallengeResult, ChallengeResult>(
              this as ChallengeResult, $identity, $identity);
  @override
  String toString() {
    return ChallengeResultMapper.ensureInitialized()
        .stringifyValue(this as ChallengeResult);
  }

  @override
  bool operator ==(Object other) {
    return ChallengeResultMapper.ensureInitialized()
        .equalsValue(this as ChallengeResult, other);
  }

  @override
  int get hashCode {
    return ChallengeResultMapper.ensureInitialized()
        .hashValue(this as ChallengeResult);
  }
}

extension ChallengeResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChallengeResult, $Out> {
  ChallengeResultCopyWith<$R, ChallengeResult, $Out> get $asChallengeResult =>
      $base.as((v, t, t2) => _ChallengeResultCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChallengeResultCopyWith<$R, $In extends ChallengeResult, $Out>
    implements ChallengeResultBaseCopyWith<$R, $In, $Out> {
  BowlingChallengeCopyWith<$R, BowlingChallenge, BowlingChallenge>
      get challenge;
  @override
  FrameCopyWith<$R, Frame, Frame> get frameData;
  @override
  $R call(
      {int? game,
      int? frame,
      int? strength,
      BowlingChallenge? challenge,
      Frame? frameData,
      bool? isSuccess});
  ChallengeResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ChallengeResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChallengeResult, $Out>
    implements ChallengeResultCopyWith<$R, ChallengeResult, $Out> {
  _ChallengeResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChallengeResult> $mapper =
      ChallengeResultMapper.ensureInitialized();
  @override
  BowlingChallengeCopyWith<$R, BowlingChallenge, BowlingChallenge>
      get challenge =>
          $value.challenge.copyWith.$chain((v) => call(challenge: v));
  @override
  FrameCopyWith<$R, Frame, Frame> get frameData =>
      $value.frameData.copyWith.$chain((v) => call(frameData: v));
  @override
  $R call(
          {int? game,
          int? frame,
          Object? strength = $none,
          BowlingChallenge? challenge,
          Frame? frameData,
          bool? isSuccess}) =>
      $apply(FieldCopyWithData({
        if (game != null) #game: game,
        if (frame != null) #frame: frame,
        if (strength != $none) #strength: strength,
        if (challenge != null) #challenge: challenge,
        if (frameData != null) #frameData: frameData,
        if (isSuccess != null) #isSuccess: isSuccess
      }));
  @override
  ChallengeResult $make(CopyWithData data) => ChallengeResult(
      game: data.get(#game, or: $value.game),
      frame: data.get(#frame, or: $value.frame),
      strength: data.get(#strength, or: $value.strength),
      challenge: data.get(#challenge, or: $value.challenge),
      frameData: data.get(#frameData, or: $value.frameData),
      isSuccess: data.get(#isSuccess, or: $value.isSuccess));

  @override
  ChallengeResultCopyWith<$R2, ChallengeResult, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChallengeResultCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FinalChallengeResultMapper extends ClassMapperBase<FinalChallengeResult> {
  FinalChallengeResultMapper._();

  static FinalChallengeResultMapper? _instance;
  static FinalChallengeResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FinalChallengeResultMapper._());
      ChallengeResultBaseMapper.ensureInitialized();
      TenthFrameBowlingChallengeMapper.ensureInitialized();
      FrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FinalChallengeResult';

  static int _$game(FinalChallengeResult v) => v.game;
  static const Field<FinalChallengeResult, int> _f$game = Field('game', _$game);
  static int _$frame(FinalChallengeResult v) => v.frame;
  static const Field<FinalChallengeResult, int> _f$frame =
      Field('frame', _$frame);
  static int? _$strength(FinalChallengeResult v) => v.strength;
  static const Field<FinalChallengeResult, int> _f$strength =
      Field('strength', _$strength, opt: true);
  static TenthFrameBowlingChallenge _$challenge(FinalChallengeResult v) =>
      v.challenge;
  static const Field<FinalChallengeResult, TenthFrameBowlingChallenge>
      _f$challenge = Field('challenge', _$challenge);
  static Frame _$frameData(FinalChallengeResult v) => v.frameData;
  static const Field<FinalChallengeResult, Frame> _f$frameData =
      Field('frameData', _$frameData);
  static bool _$isSuccess(FinalChallengeResult v) => v.isSuccess;
  static const Field<FinalChallengeResult, bool> _f$isSuccess =
      Field('isSuccess', _$isSuccess, opt: true, def: false);

  @override
  final MappableFields<FinalChallengeResult> fields = const {
    #game: _f$game,
    #frame: _f$frame,
    #strength: _f$strength,
    #challenge: _f$challenge,
    #frameData: _f$frameData,
    #isSuccess: _f$isSuccess,
  };

  static FinalChallengeResult _instantiate(DecodingData data) {
    return FinalChallengeResult(
        game: data.dec(_f$game),
        frame: data.dec(_f$frame),
        strength: data.dec(_f$strength),
        challenge: data.dec(_f$challenge),
        frameData: data.dec(_f$frameData),
        isSuccess: data.dec(_f$isSuccess));
  }

  @override
  final Function instantiate = _instantiate;

  static FinalChallengeResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FinalChallengeResult>(map);
  }

  static FinalChallengeResult fromJson(String json) {
    return ensureInitialized().decodeJson<FinalChallengeResult>(json);
  }
}

mixin FinalChallengeResultMappable {
  String toJson() {
    return FinalChallengeResultMapper.ensureInitialized()
        .encodeJson<FinalChallengeResult>(this as FinalChallengeResult);
  }

  Map<String, dynamic> toMap() {
    return FinalChallengeResultMapper.ensureInitialized()
        .encodeMap<FinalChallengeResult>(this as FinalChallengeResult);
  }

  FinalChallengeResultCopyWith<FinalChallengeResult, FinalChallengeResult,
      FinalChallengeResult> get copyWith => _FinalChallengeResultCopyWithImpl<
          FinalChallengeResult, FinalChallengeResult>(
      this as FinalChallengeResult, $identity, $identity);
  @override
  String toString() {
    return FinalChallengeResultMapper.ensureInitialized()
        .stringifyValue(this as FinalChallengeResult);
  }

  @override
  bool operator ==(Object other) {
    return FinalChallengeResultMapper.ensureInitialized()
        .equalsValue(this as FinalChallengeResult, other);
  }

  @override
  int get hashCode {
    return FinalChallengeResultMapper.ensureInitialized()
        .hashValue(this as FinalChallengeResult);
  }
}

extension FinalChallengeResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FinalChallengeResult, $Out> {
  FinalChallengeResultCopyWith<$R, FinalChallengeResult, $Out>
      get $asFinalChallengeResult => $base.as(
          (v, t, t2) => _FinalChallengeResultCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FinalChallengeResultCopyWith<
    $R,
    $In extends FinalChallengeResult,
    $Out> implements ChallengeResultBaseCopyWith<$R, $In, $Out> {
  TenthFrameBowlingChallengeCopyWith<$R, TenthFrameBowlingChallenge,
      TenthFrameBowlingChallenge> get challenge;
  @override
  FrameCopyWith<$R, Frame, Frame> get frameData;
  @override
  $R call(
      {int? game,
      int? frame,
      int? strength,
      TenthFrameBowlingChallenge? challenge,
      Frame? frameData,
      bool? isSuccess});
  FinalChallengeResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FinalChallengeResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FinalChallengeResult, $Out>
    implements FinalChallengeResultCopyWith<$R, FinalChallengeResult, $Out> {
  _FinalChallengeResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FinalChallengeResult> $mapper =
      FinalChallengeResultMapper.ensureInitialized();
  @override
  TenthFrameBowlingChallengeCopyWith<$R, TenthFrameBowlingChallenge,
          TenthFrameBowlingChallenge>
      get challenge =>
          $value.challenge.copyWith.$chain((v) => call(challenge: v));
  @override
  FrameCopyWith<$R, Frame, Frame> get frameData =>
      $value.frameData.copyWith.$chain((v) => call(frameData: v));
  @override
  $R call(
          {int? game,
          int? frame,
          Object? strength = $none,
          TenthFrameBowlingChallenge? challenge,
          Frame? frameData,
          bool? isSuccess}) =>
      $apply(FieldCopyWithData({
        if (game != null) #game: game,
        if (frame != null) #frame: frame,
        if (strength != $none) #strength: strength,
        if (challenge != null) #challenge: challenge,
        if (frameData != null) #frameData: frameData,
        if (isSuccess != null) #isSuccess: isSuccess
      }));
  @override
  FinalChallengeResult $make(CopyWithData data) => FinalChallengeResult(
      game: data.get(#game, or: $value.game),
      frame: data.get(#frame, or: $value.frame),
      strength: data.get(#strength, or: $value.strength),
      challenge: data.get(#challenge, or: $value.challenge),
      frameData: data.get(#frameData, or: $value.frameData),
      isSuccess: data.get(#isSuccess, or: $value.isSuccess));

  @override
  FinalChallengeResultCopyWith<$R2, FinalChallengeResult, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FinalChallengeResultCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
