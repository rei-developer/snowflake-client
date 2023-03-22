import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<bool> saveImageToGallery(String url) async {
  try {
    final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    if (response.statusCode == 200) {
      final bytes = response.data;
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(bytes),
        quality: 100,
        name: 'snowflake-${DateTime.now().millisecondsSinceEpoch}.webp',
      );
      return result['isSuccess'] as bool;
    }
  } catch (err) {
    print('saveImageToGallery error => $err');
    Fluttertoast.showToast(msg: err.toString());
  }
  return false;
}
