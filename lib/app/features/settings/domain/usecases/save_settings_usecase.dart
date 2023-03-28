import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_storage_repository.dart';

abstract class SaveSettingsUseCase {
  Future<Result<void, LocalStorageFailure>> call(SettingsEntity settings);
}

class SaveSettingsUseCaseImpl implements SaveSettingsUseCase {
  final SettingsStorageRepository _repository;

  SaveSettingsUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalStorageFailure>> call(SettingsEntity settings) {
    return _repository.saveSettings(settings);
  }
}
