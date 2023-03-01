import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';

abstract class IDictionaryLocalRepository extends StateNotifier<Box> {
  IDictionaryLocalRepository(super.state);

  DictionaryEntity? select(int index);

  Future<bool> insert(DictionaryEntity dictionary);

  Future<bool> update(DictionaryEntity dictionary);

  Future<bool> upsert(DictionaryEntity dictionary);

  Future<void> save(List<DictionaryEntity> dictionaries);

  Future<void> delete();

  Future<void> deleteMany(List<DictionaryEntity> dictionaries);

  List<DictionaryEntity> get dictionaries;
}
