import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';

class DictionaryContainer extends ConsumerStatefulWidget {
  const DictionaryContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<DictionaryContainer> createState() => _DictionaryContainerState();
}

class _DictionaryContainerState extends ConsumerState<DictionaryContainer> {
  @override
  Widget build(BuildContext context) {
    final dictionaryCtrl = ref.read(dictionaryControllerProvider);
    return Container(
      child: Column(
        children: [
          Text('test'),
          SizedBox(height: 50.r),
          MaterialButton(
            color: Colors.blue,
            child: Text('단어 게임으로 이동'),
            onPressed: () => dictionaryCtrl.goToVocabularyPractice(context),
          ),
        ],
      ),
    );
  }
}
