import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snowflake_client/auth/entity/auth.entity.dart';
import 'package:snowflake_client/auth/entity/auth_type.entity.dart';
import 'package:snowflake_client/config/hive.config.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/vocabulary_practice.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';

class HiveInit {
  HiveInit._();

  static Future<void> run() async {
    await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
    Hive
      ..registerAdapter(AuthEntityAdapter())
      ..registerAdapter(AuthTypeAdapter())
      ..registerAdapter(DictionaryEntityAdapter())
      ..registerAdapter(WordEntityAdapter())
      ..registerAdapter(VocabularyPracticeEntityAdapter());
    final boxes = [
      '',
      HiveBox.AUTH.name,
      HiveBox.DICTIONARY.name,
    ];
    for (final box in boxes) {
      await Hive.openBox(box);
    }
  }
}
