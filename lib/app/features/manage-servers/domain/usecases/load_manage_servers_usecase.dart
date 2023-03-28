import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/manage_server_entity.dart';
import '../repositories/manage_servers_storage_repository.dart';

abstract class LoadManageServersUseCase {
  Future<Result<List<ManageServerEntity>, LocalStorageFailure>> call();
}

class LoadManageServersUseCaseImpl implements LoadManageServersUseCase {
  final ManageServersStorageRepository _repository;

  LoadManageServersUseCaseImpl(this._repository);
  @override
  Future<Result<List<ManageServerEntity>, LocalStorageFailure>> call() {
    return _repository.loadManageServers();
  }
}
