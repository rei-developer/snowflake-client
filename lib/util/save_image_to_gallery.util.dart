import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> saveImageToGallery(String url) async {
  try {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final result = await saveImageToDevice(bytes);
      print('File saved to gallery: $result');
    } else {
      throw Exception('Failed to download image');
    }
  } catch (err) {
    print('saveImageToGallery error => $err');
    Fluttertoast.showToast(msg: err.toString());
  }
}

Future<bool> saveImageToDevice(Uint8List bytes) async {
  if (Platform.isAndroid) {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    final String filePath = '$appDirPath/snowflake-${DateTime.now().millisecondsSinceEpoch}.webp';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return await ImageGallerySaver.saveFile(filePath);
  } else if (Platform.isIOS) {
    return await saveImageToPhotos(bytes);
  } else {
    Fluttertoast.showToast(msg: 'unsupported platform');
    throw Exception('Unsupported platform');
  }
}

Future<bool> saveImageToPhotos(Uint8List bytes) async =>
    await const MethodChannel('image_gallery_saver').invokeMethod(
      'saveImageToPhotos',
      {'bytes': bytes},
    );
