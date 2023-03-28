import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_storage/errors/local_storage_failure.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_storage_repository.dart';
import '../data_source/settings_storage_datasource.dart';
import '../dto/settings_dto.dart';

class SettingsStorageRepositoryImpl implements SettingsStorageRepository {
  final SettingsStorageDataSource _dataSource;

  SettingsStorageRepositoryImpl(this._dataSource);

  @override
  Future<Result<void, LocalStorageFailure>> deleteSettings() async {
    try {
      await _dataSource.deleteSettings();
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<SettingsEntity, LocalStorageFailure>> loadSettings() async {
    try {
      final result = await _dataSource.loadSettings();
      return Success(result);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, LocalStorageFailure>> saveSettings(SettingsEntity settings) async {
    try {
      await _dataSource.saveSettings(SettingsDTO.fromEntity(settings));
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalStorageFailure(e.toString()));
    }
  }
}
