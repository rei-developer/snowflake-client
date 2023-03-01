import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/dictionary/provider/word_matching.provider.dart';
import 'package:snowflake_client/title/title.const.dart';
import 'package:snowflake_client/utils/asset_loader.dart';
import 'package:snowflake_client/utils/func.util.dart';
import 'package:snowflake_client/utils/russian_alphabet.util.dart';

class WordMatchingContainer extends ConsumerStatefulWidget {
  const WordMatchingContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<WordMatchingContainer> createState() => _WordMatchingContainerState();
}

class _WordMatchingContainerState extends ConsumerState<WordMatchingContainer> {
  @override
  Widget build(BuildContext context) => HookBuilder(
        builder: (context) {
          final wordMatchingCtrl = ref.watch(wordMatchingControllerProvider.notifier);
          final wordMatchingState = ref.watch(wordMatchingControllerProvider);
          useEffect(() {
            wordMatchingCtrl.init();
            return () => wordMatchingCtrl.clear();
          }, [wordMatchingCtrl]);
          if (!wordMatchingCtrl.isRunning) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 20.r),
                  MaterialButton(
                    color: Colors.blue,
                    child: const Text('단어 게임으로 돌아가기'),
                    onPressed: () => wordMatchingCtrl.goToVocabularyPractice(context),
                  ),
                ],
              ),
            );
          }
          if (!wordMatchingCtrl.hasQuestions) {
            return const Text('문제 없음');
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: AssetLoader(TitleBackgroundImage.TOWN_NIGHT.path).cover,
            ),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.r, sigmaY: 10.r),
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Text(
                                  wordMatchingCtrl.question?.word ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.r,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'AnastasiaScript',
                                  ),
                                ),
                                Text(
                                  wordMatchingCtrl.question?.word ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.r),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '라운드 : ${wordMatchingState.round} / ${wordMatchingState.maxRound}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10.r),
                                Text(
                                  '점수 : ${wordMatchingState.score} / ${wordMatchingState.maxScore}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.r,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.r),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                wordMatchingState.maxLife,
                                (index) => Text(
                                  wordMatchingState.life > index ? '❤' : '💔',
                                  style: TextStyle(fontSize: 24.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ...mapIndexed(
                              wordMatchingState.candidates,
                              (index, e) => MaterialButton(
                                color: Colors.yellow,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('${russianAlphabet[index]}) ${e.meaning}'),
                                ),
                                onPressed: () => wordMatchingCtrl.judgment(e),
                              ),
                            ),
                          ].superJoin(SizedBox(height: 10.r)).toList(),
                        ),
                        MaterialButton(
                          color: Colors.black,
                          child: const Text('돌아가기'),
                          onPressed: () => wordMatchingCtrl.goToVocabularyPractice(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
