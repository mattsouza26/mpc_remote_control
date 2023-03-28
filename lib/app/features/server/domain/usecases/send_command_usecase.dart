import 'package:result_dart/result_dart.dart';

import '../entities/server_request_entity.dart';
import '../entities/server_response_entity.dart';
import '../errors/server_connection_failure.dart';
import '../repositories/server_repository.dart';

abstract class SendCommandUseCase {
  Future<Result<ServerResponseEntity, ServerFailure>> call(ServerRequestEntity request);
}

class SendCommandUseCaseImpl implements SendCommandUseCase {
  final ServerRepository _repository;
  SendCommandUseCaseImpl(this._repository);
  @override
  Future<Result<ServerResponseEntity, ServerFailure>> call(ServerRequestEntity request) {
    return _repository.sendCommand(request);
  }
}
