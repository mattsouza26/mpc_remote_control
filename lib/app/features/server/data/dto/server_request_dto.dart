import '../../domain/entities/server_request_entity.dart';

class ServerRequestDTO extends ServerRequestEntity {
  const ServerRequestDTO({
    required super.server,
    required super.command,
    super.seek,
    super.volume,
  });

  factory ServerRequestDTO.fromEntity(ServerRequestEntity entity) {
    return ServerRequestDTO(
      server: entity.server,
      command: entity.command,
      volume: entity.volume,
      seek: entity.seek,
    );
  }
}
