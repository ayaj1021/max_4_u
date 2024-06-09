//  static Future<String> getExternalDocumentPath() async {
//     var status = await Permission.storage.status;

//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }

//     Directory directory = Directory('');

//     if (Platform.isAndroid) {
//       // Redirects to the android download folder
//       directory = Directory('/storage/emulated/0/Download');
//     } else {
//       directory = await getApplicationDocumentsDirectory();
//     }

//     final exPath = directory.path;
//     await Directory(exPath).create(recursive: true);
//     return exPath;
//   }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class SaveAndOpenDocument {
  static Future<File> savePdf(
      {required String name, required Document pdf}) async {
    final root = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
        final file = File('${root!.path}/$name');
        await file.writeAsBytes(await pdf.save());
        debugPrint('${root.path}/$name');
        return file;
  }

  static Future<void> openPdf(File file)async{
final path = file.path;
await OpenFile.open(path);
  }
}
