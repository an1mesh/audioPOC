import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final player = AudioPlayer();
  final tts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      storagePermission();
    }

    tts.setLanguage('hi-IN');
    tts.setSpeechRate(0.5);
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
                  await player.play(DeviceFileSource(
                      "C:/Users/aniro/Downloads/iphone_13_original.mp3"));
                } else if (Platform.isAndroid) {
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
                if (player.state == PlayerState.paused) {
                  print('paused');
                }
              },
              child: const Text('Pause'),
            ),
            ElevatedButton(
              onPressed: () async {
                var lang = await tts.getLanguages;
                print(lang);
                tts.speak('Swalekhan Typing Tutor');
                print(FlutterTts().getLanguages);
              },
              child: const Text('Speak'),
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
            title: Text('Storage permission'),
            content: Text('Please grant storage permission'),
            actions: [
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

//"C:/Users/aniro/Downloads/iphone_13_original.mp3"
