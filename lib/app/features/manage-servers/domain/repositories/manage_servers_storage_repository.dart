import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/manage_server_entity.dart';

abstract class ManageServersStorageRepository {
  Future<Result<void, LocalStorageFailure>> saveManageServer(ManageServerEntity manageServer);
  Future<Result<void, LocalStorageFailure>> editManageServer(ManageServerEntity manageServer);
  Future<Result<void, LocalStorageFailure>> deleteManageServer(ManageServerEntity manageServer);
  Future<Result<List<ManageServerEntity>, LocalStorageFailure>> loadManageServers();
}
