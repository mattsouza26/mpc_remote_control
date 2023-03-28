import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/server_response_entity.dart';
import '../errors/server_connection_failure.dart';
import '../repositories/server_repository.dart';

abstract class CheckServerUseCase {
  Future<Result<ServerResponseEntity, ServerFailure>> call(Server server);
}

class CheckServerUseCaseImpl implements CheckServerUseCase {
  final ServerRepository _repository;
  CheckServerUseCaseImpl(this._repository);
  @override
  Future<Result<ServerResponseEntity, ServerFailure>> call(Server server) {
    return _repository.checkServer(server);
  }
}
