import '../../../../core/services/local_storage/errors/local_storage_exception.dart';
import '../../../../core/services/local_storage/local_storage_service.dart';
import '../dto/settings_dto.dart';

abstract class SettingsStorageDataSource {
  Future<void> saveSettings(SettingsDTO settings);
  Future<void> deleteSettings();
  Future<SettingsDTO> loadSettings();
}

class SettingsStorageDataSourceImpl implements SettingsStorageDataSource {
  final LocalStorageService _service;

  SettingsStorageDataSourceImpl(this._service);

  final String _dbName = "settings";
  final String _key = "app_settings";

  @override
  Future<void> deleteSettings() async {
    try {
      final result = await _service.deleteDisk();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SettingsDTO> loadSettings() async {
    try {
      final result = await _service.get<SettingsDTO>(_dbName, _key);
      if (result == null) {
        throw const LocalStorageException();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveSettings(SettingsDTO settings) async {
    try {
      final result = await _service.save<SettingsDTO>(_dbName, _key, settings);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
