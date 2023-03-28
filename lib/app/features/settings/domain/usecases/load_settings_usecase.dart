import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_storage_repository.dart';

abstract class LoadSettingsUseCase {
  Future<Result<SettingsEntity, LocalStorageFailure>> call();
}

class LoadSettingsUseCaseImpl implements LoadSettingsUseCase {
  final SettingsStorageRepository _repository;

  LoadSettingsUseCaseImpl(this._repository);
  @override
  Future<Result<SettingsEntity, LocalStorageFailure>> call() async {
    return _repository.loadSettings();
  }
}
