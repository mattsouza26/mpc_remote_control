import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/media_status_entity.dart';
import '../errors/server_connection_failure.dart';
import '../repositories/server_repository.dart';

abstract class GetMediaStatusUseCase {
  Future<Result<MediaStatusEntity, ServerFailure>> call(Server server);
}

class GetMediaStatusUseCaseImpl implements GetMediaStatusUseCase {
  final ServerRepository _repository;

  GetMediaStatusUseCaseImpl(this._repository);
  @override
  Future<Result<MediaStatusEntity, ServerFailure>> call(Server server) {
    return _repository.getMediaStatus(server);
  }
}
