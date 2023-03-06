import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final dictionaryCtrl = ref.read(dictionaryControllerProvider(context));
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
            const Text('Hello, world!'),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.amberAccent,
              onPressed: dictionaryCtrl.setup,
              child: const Text('Set up'),
            ),
            SizedBox(height: 20.r),
            MaterialButton(
              color: Colors.amberAccent,
              onPressed: dictionaryCtrl.goToDictionary,
              child: const Text('Go to Dictionary'),
            ),
          ],
        ),
      ),
    );
  }
}
