import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snowflake_client/config/hive.config.dart';
import 'package:snowflake_client/dictionary/entity/dictionary.entity.dart';
import 'package:snowflake_client/dictionary/entity/word.entity.dart';

class HiveInit {
  HiveInit._();

  static Future<void> run() async {
    await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
    Hive
      ..registerAdapter(DictionaryEntityAdapter())
      ..registerAdapter(WordEntityAdapter());
    final boxes = [
      '',
      HiveBox.DICTIONARY.name,
    ];
    for (final box in boxes) {
      await Hive.openBox(box);
    }
  }
}
