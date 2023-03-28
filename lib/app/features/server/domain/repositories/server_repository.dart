import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/media_status_entity.dart';
import '../entities/server_request_entity.dart';
import '../entities/server_response_entity.dart';
import '../errors/server_connection_failure.dart';

abstract class ServerRepository {
  Future<Result<ServerResponseEntity, ServerFailure>> sendCommand(ServerRequestEntity request);
  Future<Result<MediaStatusEntity, ServerFailure>> getMediaStatus(Server server);
  Future<Result<ServerResponseEntity, ServerFailure>> checkServer(Server server);
}
