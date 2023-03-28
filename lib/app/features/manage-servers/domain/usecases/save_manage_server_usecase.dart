import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/manage_server_entity.dart';
import '../repositories/manage_servers_storage_repository.dart';

abstract class SaveManageServerUseCase {
  Future<Result<void, LocalStorageFailure>> call(ManageServerEntity manageServer);
}

class SaveManageServerUseCaseImpl implements SaveManageServerUseCase {
  final ManageServersStorageRepository _repository;

  SaveManageServerUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalStorageFailure>> call(ManageServerEntity manageServer) {
    return _repository.saveManageServer(manageServer);
  }
}
