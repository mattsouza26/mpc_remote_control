import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/browser_entity.dart';
import '../errors/file_browser_failure.dart';
import '../repositories/browser_repository.dart';

abstract class GetFilesUseCase {
  Future<Result<BrowserEntity, FileBrowserFailure>> call(Server server);
}

class GetFilesUseCaseImpl implements GetFilesUseCase {
  final BrowserRepository _repository;

  GetFilesUseCaseImpl(this._repository);
  @override
  Future<Result<BrowserEntity, FileBrowserFailure>> call(Server server) {
    return _repository.getFiles(server);
  }
}
