import 'package:hive_flutter/hive_flutter.dart';
import 'package:snowflake_client/config/hive.config.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-local.repository.dart';
import 'package:snowflake_client/utils/func.util.dart';

class DictionaryLocalRepository extends IDictionaryLocalRepository {
  DictionaryLocalRepository()
      : _key = HiveStorageKey.DICTIONARY.name,
        super(Hive.box(HiveBox.DICTIONARY.name));

  final String _key;

  @override
  DictionaryEntity? select(int index) => dictionaries.firstWhereOrNull((e) => e.index == index);

  @override
  Future<bool> insert(DictionaryEntity dictionary) async {
    try {
      if (_indexOf(dictionary.index) >= 0) {
        return false;
      }
      await save([...dictionaries, dictionary]);
      return true;
    } catch (err) {
      print('DictionaryLocalRepository insert error => $err');
      return false;
    }
  }

  @override
  Future<bool> update(DictionaryEntity dictionary) async {
    try {
      final index = _indexOf(dictionary.index);
      if (index < 0) {
        return false;
      }
      final newDictionary = dictionaries;
      newDictionary[index] = dictionary;
      await save(newDictionary);
      return true;
    } catch (err) {
      print('DictionaryLocalRepository update error => $err');
      return false;
    }
  }

  @override
  Future<bool> upsert(DictionaryEntity dictionary) async =>
      _indexOf(dictionary.index) >= 0 ? await update(dictionary) : await insert(dictionary);

  @override
  Future<void> save(List<DictionaryEntity> dictionaries) => state.put(_key, dictionaries);

  @override
  Future<void> delete() => state.delete(_key);

  @override
  Future<void> deleteMany(List<DictionaryEntity> dictionaries) => save(
      [...this.dictionaries.where((e) => !dictionaries.any((i) => i.index == e.index)).toList()]);

  @override
  List<DictionaryEntity> get dictionaries =>
      (state.get(_key, defaultValue: []) as List).map((e) => e as DictionaryEntity).toList();

  int _indexOf(int index) => dictionaries.indexWhere((e) => e.index == index);
}
