import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ConstantString {
  //Get windows document location

  static Future<String> getDocumentPath() async {
    Directory windowsDir = await getApplicationDocumentsDirectory();
    print(windowsDir);
    return windowsDir.path;
  }

  //Android

  static String downlaodPathHindiAndroid =
      "/storage/emulated/0/Document/Swalekhan/Hindi/Swalekhan-Data.zip";
  static String extractPathHindiAndroid =
      "/storage/emulated/0/Document/Swalekhan/SwalekhanContent/Hindi/Swalekhan-Data";
  static String downlaodPathMarathiAndroid =
      "/storage/emulated/0/Document/Swalekhan/Marathi/Swalekhan-Data.zip";
  static String extractPathMarathiAndroid =
      "/storage/emulated/0/Document/Swalekhan/SwalekhanContent/Marathi/Swalekhan-Data";

  //Windows

  static String downlaodPathHindiWindows =
      "/storage/emulated/0/Document/Swalekhan/Hindi/Swalekhan-Data.zip";
  static String extractPathHindiWindows =
      "/storage/emulated/0/Document/Swalekhan/SwalekhanContent/Hindi/Swalekhan-Data";
  static String downlaodPathMarathiWindows =
      "/storage/emulated/0/Document/Swalekhan/Marathi/Swalekhan-Data.zip";
  static String extractPathMarathiWindows =
      "/storage/emulated/0/Document/Swalekhan/SwalekhanContent/Marathi/Swalekhan-Data";

  //Download url

  static String downloadUrl = "http://stage.swalekhan.org/Swalekhan-Data.zip";
}
