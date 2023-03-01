import 'package:snowflake_client/dictionary/entity/word.entity.dart';
import 'package:snowflake_client/dictionary/model/word_matching.model.dart';

abstract class IWordMatchingService {
  List<WordEntity> setup(WordMatchingModel wordMatching);

  List<WordEntity> generateCandidates(WordMatchingModel wordMatching);
}
