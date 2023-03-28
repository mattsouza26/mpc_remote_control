import 'package:result_dart/result_dart.dart';

import '../../../../core/models/server.dart';
import '../entities/browser_entity.dart';
import '../errors/file_browser_failure.dart';

abstract class BrowserRepository {
  Future<Result<BrowserEntity, FileBrowserFailure>> getFiles(Server server);
  Future<Result<BrowserEntity, FileBrowserFailure>> openFolder(Server server, String path);
  Future<Result<void, FileBrowserFailure>> openFile(Server server, String path);
}
