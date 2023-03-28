import '../../domain/entities/server_response_entity.dart';

class ServerResponseDTO extends ServerResponseEntity {
  const ServerResponseDTO({
    required super.server,
    super.command,
    super.message,
  });
}
