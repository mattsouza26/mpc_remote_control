import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../entities/settings_entity.dart';

abstract class SettingsStorageRepository {
  Future<Result<void, LocalStorageFailure>> saveSettings(SettingsEntity settings);
  Future<Result<void, LocalStorageFailure>> deleteSettings();
  Future<Result<SettingsEntity, LocalStorageFailure>> loadSettings();
}
