import 'package:equatable/equatable.dart';

import '../../domain/entities/media_status_entity.dart';

class MediaStatusDTO extends MediaStatusEntity with EquatableMixin {
  MediaStatusDTO({
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
  }) : super(
          fileName: fileName,
          filePath: filePath,
          filePathArg: filePathArg,
          fileDir: fileDir,
          fileDirArg: fileDirArg,
          state: state,
          position: position,
          positionStr: positionStr,
          duration: duration,
          durationStr: durationStr,
          volume: volume,
          muted: muted,
        );

  factory MediaStatusDTO.fromEntity(MediaStatusEntity entity) {
    return MediaStatusDTO(
      fileName: entity.fileName.value,
      filePath: entity.filePath.value,
      filePathArg: entity.filePathArg.value,
      fileDir: entity.fileDir.value,
      fileDirArg: entity.fileDirArg.value,
      state: entity.state.value,
      position: entity.position.value,
      positionStr: entity.positionStr.value,
      duration: entity.duration.value,
      durationStr: entity.durationStr.value,
      volume: entity.volume.value,
      muted: entity.muted.value,
    );
  }
  factory MediaStatusDTO.fromMap(Map<String, dynamic> map) {
    return MediaStatusDTO(
      fileName: map['fileName'] as String,
      filePath: map['filePath'] as String,
      filePathArg: map['filePathArg'] as String,
      fileDir: map['fileDir'] as String,
      fileDirArg: map['fileDirArg'] as String,
      state: map['state'] as FileState,
      position: map['position'] as int,
      positionStr: map['positionStr'] as String,
      duration: map['duration'] as int,
      durationStr: map['durationStr'] as String,
      volume: map['volume'] as int,
      muted: map['muted'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName.value,
      'filePath': filePath.value,
      'filePathArg': filePathArg.value,
      'fileDir': fileDir.value,
      'fileDirArg': fileDirArg.value,
      'state': state.value.name,
      'position': position.value,
      'positionStr': positionStr.value,
      'duration': duration.value,
      'durationStr': durationStr.value,
      'volume': volume.value,
      'muted': muted.value,
    };
  }

  @override
  List<Object?> get props => [
        fileName.value,
        filePath.value,
        filePathArg.value,
        fileDir.value,
        fileDirArg.value,
        state.value.name,
        position.value,
        positionStr.value,
        duration.value,
        durationStr.value,
        volume.value,
        muted.value,
      ];
}
