// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum FileState {
  notReproducing("Not Reproducing", -1),
  stopped("Stopped", 0),
  paused("Paused", 1),
  reproducing("Reproducing", 2);

  final String name;
  final int code;
  const FileState(this.name, this.code);
}

class MediaStatusEntity {
  final ValueNotifier<String> fileName;
  final ValueNotifier<String> filePath;
  final ValueNotifier<String> filePathArg;
  final ValueNotifier<String> fileDir;
  final ValueNotifier<String> fileDirArg;
  final ValueNotifier<FileState> state;
  final ValueNotifier<int> position;
  final ValueNotifier<String> positionStr;
  final ValueNotifier<int> duration;
  final ValueNotifier<String> durationStr;
  final ValueNotifier<int> volume;
  final ValueNotifier<bool> muted;

  MediaStatusEntity({
    required String fileName,
    required String filePath,
    required String filePathArg,
    required String fileDir,
    required String fileDirArg,
    required FileState state,
    required int position,
    required String positionStr,
    required int duration,
    required String durationStr,
    required int volume,
    required bool muted,
  })  : fileName = ValueNotifier(fileName),
        filePath = ValueNotifier(filePath),
        filePathArg = ValueNotifier(filePathArg),
        fileDir = ValueNotifier(fileDir),
        fileDirArg = ValueNotifier(fileDirArg),
        state = ValueNotifier(state),
        position = ValueNotifier(position),
        positionStr = ValueNotifier(positionStr),
        duration = ValueNotifier(duration),
        durationStr = ValueNotifier(durationStr),
        volume = ValueNotifier(volume),
        muted = ValueNotifier(muted);
}
