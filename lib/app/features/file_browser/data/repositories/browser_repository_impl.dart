import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../../domain/entities/browser_entity.dart';
import '../../domain/errors/file_browser_failure.dart';
import '../../domain/repositories/browser_repository.dart';
import '../data_source/browser_datasource.dart';

class BrowserRepositoryImpl implements BrowserRepository {
  final BrowserDataSource _dataSource;

  BrowserRepositoryImpl(this._dataSource);
  @override
  Future<Result<BrowserEntity, FileBrowserFailure>> getFiles(Server server) async {
    try {
      final response = await _dataSource.getFiles(server);
      return Success(response);
    } catch (e) {
      return Failure(FileBrowserFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, FileBrowserFailure>> openFile(Server server, String path) async {
    try {
      await _dataSource.openFile(server, path);
      return const Success(Unit);
    } catch (e) {
      return Failure(FileBrowserFailure(e.toString()));
    }
  }

  @override
  Future<Result<BrowserEntity, FileBrowserFailure>> openFolder(Server server, String path) async {
    try {
      final response = await _dataSource.openFolder(server, path);
      return Success(response);
    } catch (e) {
      return Failure(FileBrowserFailure(e.toString()));
    }
  }
}
