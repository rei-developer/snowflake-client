import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/title/title.const.dart';
import 'package:snowflake_client/utils/asset_loader.dart';

class WordMatchingContainer extends ConsumerStatefulWidget {
  const WordMatchingContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<WordMatchingContainer> createState() => _WordMatchingContainerState();
}

class _WordMatchingContainerState extends ConsumerState<WordMatchingContainer> {
  @override
  Widget build(BuildContext context) {
    final dictionaryCtrl = ref.read(dictionaryControllerProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80.r, horizontal: 20.r),
      decoration: BoxDecoration(
        image: AssetLoader(TitleBackgroundImage.TOWN.path).cover,
      ),
      child: Column(
        children: [
          Text('test'),
          SizedBox(height: 50.r),
          MaterialButton(
            color: Colors.blue,
            child: Text('단어 게임으로 돌아가기'),
            onPressed: () => dictionaryCtrl.goToVocabularyPractice(context),
          ),
        ],
      ),
    );
  }
}
