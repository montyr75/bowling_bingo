// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'frame.dart';

class FrameMapper extends ClassMapperBase<Frame> {
  FrameMapper._();

  static FrameMapper? _instance;
  static FrameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FrameMapper._());
      TenthFrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Frame';

  static int? _$firstThrow(Frame v) => v.firstThrow;
  static const Field<Frame, int> _f$firstThrow =
      Field('firstThrow', _$firstThrow, opt: true);
  static int? _$secondThrow(Frame v) => v.secondThrow;
  static const Field<Frame, int> _f$secondThrow =
      Field('secondThrow', _$secondThrow, opt: true);
  static int? _$score(Frame v) => v.score;
  static const Field<Frame, int> _f$score = Field('score', _$score, opt: true);

  @override
  final MappableFields<Frame> fields = const {
    #firstThrow: _f$firstThrow,
    #secondThrow: _f$secondThrow,
    #score: _f$score,
  };

  static Frame _instantiate(DecodingData data) {
    return Frame(
        firstThrow: data.dec(_f$firstThrow),
        secondThrow: data.dec(_f$secondThrow),
        score: data.dec(_f$score));
  }

  @override
  final Function instantiate = _instantiate;

  static Frame fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Frame>(map);
  }

  static Frame fromJson(String json) {
    return ensureInitialized().decodeJson<Frame>(json);
  }
}

mixin FrameMappable {
  String toJson() {
    return FrameMapper.ensureInitialized().encodeJson<Frame>(this as Frame);
  }

  Map<String, dynamic> toMap() {
    return FrameMapper.ensureInitialized().encodeMap<Frame>(this as Frame);
  }

  FrameCopyWith<Frame, Frame, Frame> get copyWith =>
      _FrameCopyWithImpl<Frame, Frame>(this as Frame, $identity, $identity);
  @override
  String toString() {
    return FrameMapper.ensureInitialized().stringifyValue(this as Frame);
  }

  @override
  bool operator ==(Object other) {
    return FrameMapper.ensureInitialized().equalsValue(this as Frame, other);
  }

  @override
  int get hashCode {
    return FrameMapper.ensureInitialized().hashValue(this as Frame);
  }
}

extension FrameValueCopy<$R, $Out> on ObjectCopyWith<$R, Frame, $Out> {
  FrameCopyWith<$R, Frame, $Out> get $asFrame =>
      $base.as((v, t, t2) => _FrameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FrameCopyWith<$R, $In extends Frame, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? firstThrow, int? secondThrow, int? score});
  FrameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FrameCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Frame, $Out>
    implements FrameCopyWith<$R, Frame, $Out> {
  _FrameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Frame> $mapper = FrameMapper.ensureInitialized();
  @override
  $R call(
          {Object? firstThrow = $none,
          Object? secondThrow = $none,
          Object? score = $none}) =>
      $apply(FieldCopyWithData({
        if (firstThrow != $none) #firstThrow: firstThrow,
        if (secondThrow != $none) #secondThrow: secondThrow,
        if (score != $none) #score: score
      }));
  @override
  Frame $make(CopyWithData data) => Frame(
      firstThrow: data.get(#firstThrow, or: $value.firstThrow),
      secondThrow: data.get(#secondThrow, or: $value.secondThrow),
      score: data.get(#score, or: $value.score));

  @override
  FrameCopyWith<$R2, Frame, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FrameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class TenthFrameMapper extends ClassMapperBase<TenthFrame> {
  TenthFrameMapper._();

  static TenthFrameMapper? _instance;
  static TenthFrameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TenthFrameMapper._());
      FrameMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TenthFrame';

  static int? _$firstThrow(TenthFrame v) => v.firstThrow;
  static const Field<TenthFrame, int> _f$firstThrow =
      Field('firstThrow', _$firstThrow, opt: true);
  static int? _$secondThrow(TenthFrame v) => v.secondThrow;
  static const Field<TenthFrame, int> _f$secondThrow =
      Field('secondThrow', _$secondThrow, opt: true);
  static int? _$thirdThrow(TenthFrame v) => v.thirdThrow;
  static const Field<TenthFrame, int> _f$thirdThrow =
      Field('thirdThrow', _$thirdThrow, opt: true);
  static int? _$score(TenthFrame v) => v.score;
  static const Field<TenthFrame, int> _f$score =
      Field('score', _$score, opt: true);

  @override
  final MappableFields<TenthFrame> fields = const {
    #firstThrow: _f$firstThrow,
    #secondThrow: _f$secondThrow,
    #thirdThrow: _f$thirdThrow,
    #score: _f$score,
  };

  static TenthFrame _instantiate(DecodingData data) {
    return TenthFrame(
        firstThrow: data.dec(_f$firstThrow),
        secondThrow: data.dec(_f$secondThrow),
        thirdThrow: data.dec(_f$thirdThrow),
        score: data.dec(_f$score));
  }

  @override
  final Function instantiate = _instantiate;

  static TenthFrame fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TenthFrame>(map);
  }

  static TenthFrame fromJson(String json) {
    return ensureInitialized().decodeJson<TenthFrame>(json);
  }
}

mixin TenthFrameMappable {
  String toJson() {
    return TenthFrameMapper.ensureInitialized()
        .encodeJson<TenthFrame>(this as TenthFrame);
  }

  Map<String, dynamic> toMap() {
    return TenthFrameMapper.ensureInitialized()
        .encodeMap<TenthFrame>(this as TenthFrame);
  }

  TenthFrameCopyWith<TenthFrame, TenthFrame, TenthFrame> get copyWith =>
      _TenthFrameCopyWithImpl<TenthFrame, TenthFrame>(
          this as TenthFrame, $identity, $identity);
  @override
  String toString() {
    return TenthFrameMapper.ensureInitialized()
        .stringifyValue(this as TenthFrame);
  }

  @override
  bool operator ==(Object other) {
    return TenthFrameMapper.ensureInitialized()
        .equalsValue(this as TenthFrame, other);
  }

  @override
  int get hashCode {
    return TenthFrameMapper.ensureInitialized().hashValue(this as TenthFrame);
  }
}

extension TenthFrameValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TenthFrame, $Out> {
  TenthFrameCopyWith<$R, TenthFrame, $Out> get $asTenthFrame =>
      $base.as((v, t, t2) => _TenthFrameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TenthFrameCopyWith<$R, $In extends TenthFrame, $Out>
    implements FrameCopyWith<$R, $In, $Out> {
  @override
  $R call({int? firstThrow, int? secondThrow, int? thirdThrow, int? score});
  TenthFrameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TenthFrameCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TenthFrame, $Out>
    implements TenthFrameCopyWith<$R, TenthFrame, $Out> {
  _TenthFrameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TenthFrame> $mapper =
      TenthFrameMapper.ensureInitialized();
  @override
  $R call(
          {Object? firstThrow = $none,
          Object? secondThrow = $none,
          Object? thirdThrow = $none,
          Object? score = $none}) =>
      $apply(FieldCopyWithData({
        if (firstThrow != $none) #firstThrow: firstThrow,
        if (secondThrow != $none) #secondThrow: secondThrow,
        if (thirdThrow != $none) #thirdThrow: thirdThrow,
        if (score != $none) #score: score
      }));
  @override
  TenthFrame $make(CopyWithData data) => TenthFrame(
      firstThrow: data.get(#firstThrow, or: $value.firstThrow),
      secondThrow: data.get(#secondThrow, or: $value.secondThrow),
      thirdThrow: data.get(#thirdThrow, or: $value.thirdThrow),
      score: data.get(#score, or: $value.score));

  @override
  TenthFrameCopyWith<$R2, TenthFrame, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TenthFrameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
