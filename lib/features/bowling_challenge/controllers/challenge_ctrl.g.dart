// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$challengeCtrlHash() => r'197bf04284191379b94d3d0b6aaf3974fc517c0b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChallengeCtrl
    extends BuildlessAutoDisposeNotifier<ChallengeState> {
  late final int? id;
  late final BowlingChallenge challenge;
  late final int? strength;

  ChallengeState build({
    int? id,
    required BowlingChallenge challenge,
    int? strength,
  });
}

/// See also [ChallengeCtrl].
@ProviderFor(ChallengeCtrl)
const challengeCtrlProvider = ChallengeCtrlFamily();

/// See also [ChallengeCtrl].
class ChallengeCtrlFamily extends Family<ChallengeState> {
  /// See also [ChallengeCtrl].
  const ChallengeCtrlFamily();

  /// See also [ChallengeCtrl].
  ChallengeCtrlProvider call({
    int? id,
    required BowlingChallenge challenge,
    int? strength,
  }) {
    return ChallengeCtrlProvider(
      id: id,
      challenge: challenge,
      strength: strength,
    );
  }

  @override
  ChallengeCtrlProvider getProviderOverride(
    covariant ChallengeCtrlProvider provider,
  ) {
    return call(
      id: provider.id,
      challenge: provider.challenge,
      strength: provider.strength,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'challengeCtrlProvider';
}

/// See also [ChallengeCtrl].
class ChallengeCtrlProvider
    extends AutoDisposeNotifierProviderImpl<ChallengeCtrl, ChallengeState> {
  /// See also [ChallengeCtrl].
  ChallengeCtrlProvider({
    int? id,
    required BowlingChallenge challenge,
    int? strength,
  }) : this._internal(
         () => ChallengeCtrl()
           ..id = id
           ..challenge = challenge
           ..strength = strength,
         from: challengeCtrlProvider,
         name: r'challengeCtrlProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$challengeCtrlHash,
         dependencies: ChallengeCtrlFamily._dependencies,
         allTransitiveDependencies:
             ChallengeCtrlFamily._allTransitiveDependencies,
         id: id,
         challenge: challenge,
         strength: strength,
       );

  ChallengeCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.challenge,
    required this.strength,
  }) : super.internal();

  final int? id;
  final BowlingChallenge challenge;
  final int? strength;

  @override
  ChallengeState runNotifierBuild(covariant ChallengeCtrl notifier) {
    return notifier.build(id: id, challenge: challenge, strength: strength);
  }

  @override
  Override overrideWith(ChallengeCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChallengeCtrlProvider._internal(
        () => create()
          ..id = id
          ..challenge = challenge
          ..strength = strength,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        challenge: challenge,
        strength: strength,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChallengeCtrl, ChallengeState>
  createElement() {
    return _ChallengeCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChallengeCtrlProvider &&
        other.id == id &&
        other.challenge == challenge &&
        other.strength == strength;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, challenge.hashCode);
    hash = _SystemHash.combine(hash, strength.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChallengeCtrlRef on AutoDisposeNotifierProviderRef<ChallengeState> {
  /// The parameter `id` of this provider.
  int? get id;

  /// The parameter `challenge` of this provider.
  BowlingChallenge get challenge;

  /// The parameter `strength` of this provider.
  int? get strength;
}

class _ChallengeCtrlProviderElement
    extends AutoDisposeNotifierProviderElement<ChallengeCtrl, ChallengeState>
    with ChallengeCtrlRef {
  _ChallengeCtrlProviderElement(super.provider);

  @override
  int? get id => (origin as ChallengeCtrlProvider).id;
  @override
  BowlingChallenge get challenge => (origin as ChallengeCtrlProvider).challenge;
  @override
  int? get strength => (origin as ChallengeCtrlProvider).strength;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
