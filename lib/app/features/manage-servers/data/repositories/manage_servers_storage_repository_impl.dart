import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../../domain/entities/manage_server_entity.dart';
import '../../domain/repositories/manage_servers_storage_repository.dart';
import '../data_source/manage_servers_storage_datasource.dart';
import '../dto/manage_server_dto.dart';

class ManageServersStorageRepositoryImpl implements ManageServersStorageRepository {
  final ManageServersStorageDataSource _dataSource;

  ManageServersStorageRepositoryImpl(this._dataSource);
  @override
  Future<Result<void, LocalStorageFailure>> deleteManageServer(ManageServerEntity manageServer) async {
    try {
      await _dataSource.deleteManageServer(ManageServerDTO.fromEntity(manageServer));
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, LocalStorageFailure>> editManageServer(ManageServerEntity manageServer) async {
    try {
      await _dataSource.editManageServer(ManageServerDTO.fromEntity(manageServer));
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<ManageServerEntity>, LocalStorageFailure>> loadManageServers() async {
    try {
      final result = await _dataSource.loadManageServers();
      return Success(result);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, LocalStorageFailure>> saveManageServer(ManageServerEntity manageServer) async {
    try {
      await _dataSource.saveManageServer(ManageServerDTO.fromEntity(manageServer));
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }
}
