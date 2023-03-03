import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/component/dictionary_list.component.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';

class VocabularyPracticeContainer extends ConsumerStatefulWidget {
  const VocabularyPracticeContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<VocabularyPracticeContainer> createState() => _VocabularyPracticeContainerState();
}

class _VocabularyPracticeContainerState extends ConsumerState<VocabularyPracticeContainer> {
  @override
  Widget build(BuildContext context) {
    final dictionaryCtrl = ref.read(dictionaryControllerProvider(context));
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('<단어 게임장>'),
          SizedBox(height: 50.r),
          Expanded(child: DictionaryListComponent(dictionaryCtrl.fetchDictionaries())),
          SizedBox(height: 20.r),
          MaterialButton(
            color: Colors.blue,
            child: Text('단어장으로 돌아가기'),
            onPressed: dictionaryCtrl.goToDictionary,
          ),
        ],
      ),
    );
  }
}
