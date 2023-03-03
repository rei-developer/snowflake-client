import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snowflake_client/common/controller/system.controller.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/dictionary/repository/dictionary-local.repository.dart';

class SystemController extends ISystemController {
  SystemController(this.ref)
      : _dictionaryLocalRepo = ref.read(dictionaryLocalRepositoryProvider.notifier),
        super('');

  final Ref ref;
  final IDictionaryLocalRepository _dictionaryLocalRepo;

  @override
  Future<void> init() async {}
}
