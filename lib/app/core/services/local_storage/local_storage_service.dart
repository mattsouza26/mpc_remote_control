import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/manage-servers/data/dto/manage_server_dto.dart';
import '../../../features/settings/data/dto/settings_dto.dart';
import '../../models/command.dart';
import '../../models/server.dart';
import 'errors/local_storage_exception.dart';
import 'models/storage_object.dart';

abstract class LocalStorageService {
  Future<LocalStorageService> init();
  Future<T?> get<T extends StorageObject>(String dbName, String key);
  Future<List<T>?> getAll<T extends StorageObject>(String dbName);
  Future<void> save<T extends StorageObject>(String dbName, String key, T value);
  Future<bool> contains<T extends StorageObject>(String dbName, String key);
  Future<void> delete<T extends StorageObject>(String dbName, String key);
  Future<void> deleteAll<T extends StorageObject>(String dbName);
  Future<void> saveAll<T extends StorageObject>(String dbName, Map<String, T> object);
  Future<void> update<T extends StorageObject>(String dbName, String key, T value);
  Future<void> deleteDisk();
}

class HiveLocalStorageService implements LocalStorageService {
  @override
  Future<LocalStorageService> init() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    Hive.registerAdapter<SettingsDTO>(SettingsDTOAdapter());
    Hive.registerAdapter<Server>(ServerAdapter());
    Hive.registerAdapter<Command>(CommandAdapter());
    Hive.registerAdapter<ManageServerDTO>(ManageServerDTOAdapter());
    return this;
  }

  Future<Box<T>> _initialiseBoxAndGetBox<T>(String dbName) async {
    Box<T> box;

    if (!Hive.isBoxOpen(dbName)) {
      box = await Hive.openBox<T>(dbName);
    } else {
      box = Hive.box<T>(dbName);
    }
    return box;
  }

  @override
  Future<bool> contains<T extends StorageObject>(String dbName, String key) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.containsKey(key);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> delete<T extends StorageObject>(String dbName, String key) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.delete(key);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> deleteAll<T extends StorageObject>(String dbName) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final keys = box.keys;
      final boxResult = box.deleteAll(keys);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<T?> get<T extends StorageObject>(String dbName, String key) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.get(key);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<List<T>?> getAll<T extends StorageObject>(String dbName) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.values.toList().cast<T>();
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> save<T extends StorageObject>(String dbName, String key, T value) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = await box.put(key, value);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> saveAll<T extends StorageObject>(String dbName, Map<String, T> object) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.putAll(object);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> update<T extends StorageObject>(String dbName, String key, T value) async {
    try {
      final Box<T> box = await _initialiseBoxAndGetBox<T>(dbName);
      final boxResult = box.put(key, value);
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> deleteDisk() async {
    try {
      final boxResult = Hive.deleteFromDisk();
      return boxResult;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }
}
