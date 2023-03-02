import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snowflake_client/common/component/image_indicator.component.dart';
import 'package:snowflake_client/dictionary/provider/dictionary.provider.dart';
import 'package:snowflake_client/title/title.const.dart';
import 'package:snowflake_client/utils/asset_loader.dart';

class TitleContainer extends ConsumerStatefulWidget {
  const TitleContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<TitleContainer> createState() => _TitleContainerState();
}

class _TitleContainerState extends ConsumerState<TitleContainer> {
  @override
  Widget build(BuildContext context) {
    final dictionaryCtrl = ref.watch(dictionaryControllerProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80.r, horizontal: 20.r),
      decoration: BoxDecoration(
        image: AssetLoader(TitleBackgroundImage.TOWN.path).cover,
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Text('안녕하세요'),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.amberAccent,
              child: Text('셋업'),
              onPressed: () => dictionaryCtrl.setup(),
            ),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.amberAccent,
              child: Text('사전으로 이동'),
              onPressed: () => dictionaryCtrl.goToDictionary(context),
            ),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.amberAccent,
              child: Text('텍스트 표시'),
              onPressed: () => showImageIndicator(context, message: "아주 좋아", duration: 3),
            ),
          ],
        ),
      ),
    );
  }
}
