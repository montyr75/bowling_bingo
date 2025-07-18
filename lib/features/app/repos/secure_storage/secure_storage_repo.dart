import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/utils.dart';

part 'secure_storage_repo.g.dart';

enum StorageKey {
  sessionId,
  email,
  savedGame;

  String toKey() => ReCase(name).snakeCase;
}

class SecureStorageRepo {
  final storage = const FlutterSecureStorage();

  const SecureStorageRepo();

  Future<String?> read(String key) {
    return storage.read(key: key);
  }

  /// Returns a bool regardless, with null equalling false.
  Future<bool> readBool(String key) async {
    return (await storage.read(key: key))?.toBool() ?? false;
  }

  /// Returns a bool if present, or null if there is no value.
  Future<bool?> getBoolOrNull(String key) async {
    return (await storage.read(key: key))?.toBool();
  }

  Future<void> write({required String key, String? value}) async {
    return storage.write(key: key, value: value);
  }

  Future<void> writeBool({required String key, bool? value}) async {
    return storage.write(key: key, value: value?.toString());
  }

  Future<void> deleteAll() {
    return storage.deleteAll();
  }
}

@riverpod
SecureStorageRepo secureStorageRepo(Ref ref) => const SecureStorageRepo();