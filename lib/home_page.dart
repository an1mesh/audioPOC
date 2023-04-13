// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:audio_player/constant.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart';

import 'package:flutter_tts/flutter_tts.dart';

import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_speech_platform_interface/locales.dart';
import 'package:text_to_speech_platform_interface/method_channel_text_to_speech.dart';
import 'package:text_to_speech_platform_interface/text_to_speech_platform.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();
  final tts = FlutterTts();
  final downloadManager = DownloadManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      storagePermission();
    } else {
      downloadFile();
    }

    tts.setLanguage('hi-IN');
    tts.setSpeechRate(0.5);
    tts.getLanguages;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                if (Platform.isWindows) {
                  await player
                      .play(DeviceFileSource(
                          "E:\\testing\\hindi\\game_instructions\\audios\\instructions\\12_instruction1767767.mp3"))
                      .onError((error, stackTrace) => null);

                  if (player.state != PlayerState.playing) {
                    print(
                        '-----------------error encountered--------------------');
                    tts.speak(
                        "-------------------There was an error-----------------");
                  }
                  player.onPlayerStateChanged.listen((event) {
                    if (kDebugMode) {
                      if (player.state != PlayerState.playing) {
                        print(
                            '--------------------------player state changed----------------------------');
                        tts.speak(
                            "-------------------------------audio paused--------------------");
                      } else if (player.state == PlayerState.stopped) {
                        print(
                            '-----------------error encountered--------------------');
                        tts.speak(
                            "-------------------There was an error-----------------");
                      }
                    }
                  });
                } else if (Platform.isAndroid) {
                  ConstantString.getDocumentPath();
                  player.play(DeviceFileSource(
                      "/storage/emulated/0/Documents/Swalekhan/SwalekhanContent/Hindi/Swalekhan-Data/hindi/characters/audios/position/aa_ki_matra_position_audio_hindi.mp3"));
                }
                if (player.state == PlayerState.completed) {
                  print('completed');
                }
              },
              child: const Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                player.pause();
              },
              child: const Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () async {
                var voice1 = await tts.getVoices;
                var voice2 = await tts.getLanguages;
                print('--------------${voice1}---------------');
                print('--------------${voice2}---------------');
                tts.speak("");
              },
              child: const Text('Speak'),
            ),
            ElevatedButton(
              onPressed: () async {
                await compute((message) {}, extractFile());

                print('extracted');
              },
              child: const Text('Unzip'),
            ),
          ],
        ),
      ),
    );
  }

  void storagePermission() async {
    if (await Permission.storage.request().isDenied ||
        await Permission.storage.request().isRestricted ||
        await Permission.storage.request().isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Storage permission'),
            content: const Text('Please grant storage permission'),
            actions: [
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (await Permission.storage.request().isGranted) {
      await downloadFile();
      // await compute();
    }
  }

  extractFile() {
    if (Platform.isWindows) {
      extractFileToDisk("E:/testing/Swalekhan-Data.zip", "E:/testing/");
    } else if (Platform.isAndroid) {
      extractFileToDisk(
          "/storage/emulated/0/Documents/Swalekhan/Hindi/Swalekhan-Data.zip",
          "/storage/emulated/0/Documents/Swalekhan/Hindi");
    }
  }

  downloadFile() async {
    if (Platform.isAndroid) {
      // var task = downloadManager.addDownload(
      //     "http://stage.swalekhan.org/Swalekhan-Data.zip",
      //     );

      await downloadManager.addDownload(
          "http://stage.swalekhan.org/Swalekhan-Data.zip",
          "/storage/emulated/0/Documents/Swalekhan/Hindi/Swalekhan-Data.zip");
      var task = downloadManager
          .getDownload("http://stage.swalekhan.org/Swalekhan-Data.zip");
      task!.status.addListener(() {
        if (task.status.value.isCompleted) {
          print("---------done----------");
          extractFile();
        }
      });
    } else if (Platform.isWindows) {
      getExternalStorageDirectory();
    }
  }

  FutureOr<void> speak(error) {
    //tts.speak("text");
    if (kDebugMode) {
      print("text");
    }
  }
}
