import '../../../../core/services/local_storage/errors/local_storage_exception.dart';
import '../../../../core/services/local_storage/local_storage_service.dart';
import '../dto/manage_server_dto.dart';

abstract class ManageServersStorageDataSource {
  Future<void> saveManageServer(ManageServerDTO manageServer);
  Future<void> deleteManageServer(ManageServerDTO manageServer);
  Future<void> editManageServer(ManageServerDTO manageServer);
  Future<List<ManageServerDTO>> loadManageServers();
}

class ManageServersStorageDataSourceImpl implements ManageServersStorageDataSource {
  final LocalStorageService _storageService;

  ManageServersStorageDataSourceImpl(this._storageService);

  final String _dbName = "manage-servers";

  @override
  Future<void> deleteManageServer(ManageServerDTO manageServer) async {
    try {
      final result = await _storageService.delete<ManageServerDTO>(_dbName, manageServer.id);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editManageServer(ManageServerDTO manageServer) async {
    try {
      final result = await _storageService.update<ManageServerDTO>(_dbName, manageServer.id, manageServer);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ManageServerDTO>> loadManageServers() async {
    try {
      final result = await _storageService.getAll<ManageServerDTO>(_dbName);
      if (result == null) {
        throw const LocalStorageException("Not Find.");
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveManageServer(ManageServerDTO manageServer) async {
    try {
      final result = await _storageService.save<ManageServerDTO>(_dbName, manageServer.id, manageServer);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
