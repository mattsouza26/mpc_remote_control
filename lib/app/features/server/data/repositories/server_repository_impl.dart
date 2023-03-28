import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../../domain/entities/media_status_entity.dart';
import '../../domain/entities/server_request_entity.dart';
import '../../domain/entities/server_response_entity.dart';
import '../../domain/errors/server_connection_failure.dart';
import '../../domain/repositories/server_repository.dart';
import '../data_source/server_datasource.dart';
import '../dto/server_request_dto.dart';

class ServerRepositoryImpl implements ServerRepository {
  final ServerDataSource _dataSource;

  ServerRepositoryImpl(this._dataSource);

  @override
  Future<Result<MediaStatusEntity, ServerFailure>> getMediaStatus(Server server) async {
    try {
      final result = await _dataSource.getMediaStatus(server);
      return Success(result);
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<ServerResponseEntity, ServerFailure>> sendCommand(ServerRequestEntity request) async {
    try {
      final result = await _dataSource.sendCommand(ServerRequestDTO.fromEntity(request));
      return Success(result);
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<ServerResponseEntity, ServerFailure>> checkServer(Server server) async {
    try {
      final result = await _dataSource.checkServer(server);
      return Success(result);
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
}
