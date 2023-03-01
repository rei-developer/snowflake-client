import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-dummy.repository.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-local.repository.dart';
import 'package:snowflake_client/dictionary/service/dictionary.service.dart';

class DictionaryService extends IDictionaryService {
  DictionaryService(this.ref)
      : _dictionaryDummyRepo = ref.read(dictionaryDummyRepositoryProvider),
        _dictionaryLocalRepo = ref.read(dictionaryLocalRepositoryProvider.notifier);

  final Ref ref;
  final IDictionaryDummyRepository _dictionaryDummyRepo;
  final IDictionaryLocalRepository _dictionaryLocalRepo;

  @override
  Future<bool> setup(DictionaryEntity dictionary) => _dictionaryLocalRepo.upsert(dictionary);

  @override
  Future<List<DictionaryEntity>> fetchDictionaries() async => _dictionaryLocalRepo.dictionaries;

  @override
  Future<DictionaryEntity> fetchDummyDictionary() async {
    final words = await _dictionaryDummyRepo.fetchWords('russian-1');
    return DictionaryEntity(0, 'Russian words - 1', words);
  }
}
