// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mpc_remote_control/app/features/server/domain/usecases/check_server_usecase.dart';

import '../../../../core/models/command.dart';
import '../../../../core/models/server.dart';
import '../../data/dto/media_status_dto.dart';
import '../../data/dto/server_request_dto.dart';
import '../../domain/entities/media_status_entity.dart';
import '../../domain/usecases/cancel_media_notification_usecase.dart';
import '../../domain/usecases/get_media_status_usecase.dart';
import '../../domain/usecases/send_command_usecase.dart';
import '../../domain/usecases/show_media_notification_usecase.dart';
import '../models/server_selected.dart';

class ServerController extends ChangeNotifier {
  late final SendCommandUseCase _sendCommandUseCase;
  late final GetMediaStatusUseCase _getMediaStatusUseCase;
  late final CheckServerUseCase _checkServerUseCase;
  late final ShowMediaNotificationUseCase _showMediaNotificationUseCase;
  late final CancelMediaNotificationUseCase _cancelMediaNotificationUseCase;

  ServerController(
    this._sendCommandUseCase,
    this._getMediaStatusUseCase,
    this._checkServerUseCase,
    this._showMediaNotificationUseCase,
    this._cancelMediaNotificationUseCase,
  ) {
    addListener(_handleNotification);
  }

  void _emit(ServerSelected selected) {
    _serverSelected = selected;
    notifyListeners();
  }

  ServerSelected _serverSelected = const ServerSelected(state: ServerState.disconnected);
  bool _showNotification = false;
  Timer? _checkServerTimer;
  Timer? _statusTimer;
  Listenable? _mediaNotificationObserver;
  ServerSelected get selected => _serverSelected;

  Future<void> selectServer(Server server) async {
    await disconnect();
    _checkServerTimer ??= Timer.periodic(const Duration(seconds: 1), (_) async => await checkServer(server));
  }

  Future<void> checkServer(Server server) async {
    final result = await _checkServerUseCase(server);
    result.fold(
      (_) async {
        if (selected.state == ServerState.connected) return;
        _emit(ServerSelected(
          server: server,
          state: ServerState.connected,
        ));
        _statusTimer ??= Timer.periodic(const Duration(milliseconds: 500), (_) => _getMediaStatus(server));
      },
      (_) async {
        if (selected.state != ServerState.waiting) {
          _statusTimer?.cancel();
          _statusTimer = null;
          _emit(ServerSelected(
            server: server,
            state: ServerState.waiting,
          ));
          _updateMediaNotification();
        }
      },
    );
  }

  Future<void> disconnect() async {
    if (_checkServerTimer == null) return;
    _checkServerTimer?.cancel();
    _checkServerTimer = null;
    _statusTimer?.cancel();
    _statusTimer = null;
    //wait one seconds for timer be cancel
    await Future.delayed(const Duration(seconds: 1));
    if (selected.state != ServerState.disconnected) {
      _emit(const ServerSelected(state: ServerState.disconnected));
    }
  }

  void showNotification() async {
    _showNotification = true;
    await _updateMediaNotification();
  }

  void cancelNotification() async {
    _showNotification = false;
    await _removeMediaNotification();
  }

  bool isShowingNotification() {
    return _showNotification;
  }

  Future<void> sendCommand(Command command, {int? volume, int? seek}) async {
    if (selected.state == ServerState.disconnected) return;
    await _sendCommandUseCase(ServerRequestDTO(server: selected.server!, command: command, volume: volume, seek: seek));
  }

  void _handleNotification() {
    _mediaNotificationObserver?.removeListener(_updateMediaNotification);
    _mediaNotificationObserver = null;
    _mediaNotificationObserver ??= Listenable.merge([
      _serverSelected.mediaStatus?.fileName,
      _serverSelected.mediaStatus?.state,
    ]);
    _mediaNotificationObserver?.addListener(_updateMediaNotification);
  }

  Future<void> _getMediaStatus(Server server) async {
    final result = await _getMediaStatusUseCase(server);
    final mediaStatus = result.map(MediaStatusDTO.fromEntity).getOrNull();
    if (mediaStatus == null) return;
    if (_serverSelected.state != ServerState.disconnected && _serverSelected.mediaStatus != null) {
      await _updateMediaStatus(mediaStatus);
    } else {
      _emit(_serverSelected.copyWith(mediaStatus: mediaStatus));
    }
    await _updateMediaNotification();
  }

  Future<void> _removeMediaNotification() async {
    await _cancelMediaNotificationUseCase();
  }

  Future<void> _updateMediaNotification() async {
    if (!_showNotification) return;
    await _showMediaNotificationUseCase(
      selected.mediaStatus?.fileName.value,
      selected.mediaStatus?.state.value == FileState.reproducing,
    );
  }

  Future<void> _updateMediaStatus(MediaStatusDTO status) async {
    _serverSelected.mediaStatus!.fileName.value = status.fileName.value;
    _serverSelected.mediaStatus!.filePath.value = status.filePath.value;
    _serverSelected.mediaStatus!.filePathArg.value = status.filePathArg.value;
    _serverSelected.mediaStatus!.fileDir.value = status.fileDir.value;
    _serverSelected.mediaStatus!.fileDirArg.value = status.fileDirArg.value;
    _serverSelected.mediaStatus!.state.value = status.state.value;
    _serverSelected.mediaStatus!.position.value = status.position.value;
    _serverSelected.mediaStatus!.positionStr.value = status.positionStr.value;
    _serverSelected.mediaStatus!.duration.value = status.duration.value;
    _serverSelected.mediaStatus!.durationStr.value = status.durationStr.value;
    _serverSelected.mediaStatus!.volume.value = status.volume.value;
    _serverSelected.mediaStatus!.muted.value = status.muted.value;
  }
}
