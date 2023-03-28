import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/manage_server_entity.dart';
import '../repositories/manage_servers_storage_repository.dart';

abstract class EditManageServerUseCase {
  Future<Result<void, LocalStorageFailure>> call(ManageServerEntity manageServer);
}

class EditManageServerUseCaseImpl implements EditManageServerUseCase {
  final ManageServersStorageRepository _repository;

  EditManageServerUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalStorageFailure>> call(ManageServerEntity manageServer) {
    return _repository.editManageServer(manageServer);
  }
}
