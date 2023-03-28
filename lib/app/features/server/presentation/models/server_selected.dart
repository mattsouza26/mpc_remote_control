// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:mpc_remote_control/app/features/server/data/dto/media_status_dto.dart';

import '../../../../core/models/server.dart';

enum ServerState {
  disconnected("Disconnected"),
  waiting("Waiting"),
  connected("Connected");

  final String name;
  const ServerState(this.name);
}

class ServerSelected extends Equatable {
  final Server? server;
  final ServerState state;
  final MediaStatusDTO? mediaStatus;

  const ServerSelected({
    this.server,
    required this.state,
    this.mediaStatus,
  });

  ServerSelected copyWith({
    Server? server,
    ServerState? state,
    MediaStatusDTO? mediaStatus,
  }) {
    return ServerSelected(
      server: server ?? this.server,
      state: state ?? this.state,
      mediaStatus: mediaStatus ?? this.mediaStatus,
    );
  }

  @override
  List<Object?> get props => [server, state, mediaStatus];
}
