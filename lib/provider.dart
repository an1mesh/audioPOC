import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  final downloadManager = DownloadManager();
  var downloadProgress;

  void downloadFile() async {
    if (Platform.isAndroid) {
      await downloadManager.addDownload(
          "http://stage.swalekhan.org/Swalekhan-Data.zip",
          "/storage/emulated/0/Download/Swalekhan-Data.zip");
    } else if (Platform.isWindows) {
      await downloadManager.addDownload(
          "http://stage.swalekhan.org/Swalekhan-Data.zip", "E:/testing");
    }

    downloadProgress = downloadManager.getDownload("http://stage.swalekhan.org/Swalekhan-Data.zip")!.progress;
    print(downloadProgress);
    notifyListeners();
  }
}
