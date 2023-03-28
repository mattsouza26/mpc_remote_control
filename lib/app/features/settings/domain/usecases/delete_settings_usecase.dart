import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../repositories/settings_storage_repository.dart';

abstract class DeleteSettingsUseCase {
  Future<Result<void, LocalStorageFailure>> call();
}

class DeleteSettingsUseCaseImpl implements DeleteSettingsUseCase {
  final SettingsStorageRepository _repository;

  DeleteSettingsUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalStorageFailure>> call() {
    return _repository.deleteSettings();
  }
}
