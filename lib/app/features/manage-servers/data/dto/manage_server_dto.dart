import 'package:hive_flutter/hive_flutter.dart';
import 'package:mpc_remote_control/app/core/services/local_storage/models/storage_object.dart';

import '../../../../core/models/server.dart';
import '../../domain/entities/manage_server_entity.dart';

part 'manage_server_dto.g.dart';

@HiveType(typeId: 3)
class ManageServerDTO extends ManageServerEntity with StorageObject {
  ManageServerDTO({
    @HiveField(0) required super.id,
    @HiveField(1) required super.name,
    @HiveField(2) required super.server,
  });
  factory ManageServerDTO.fromEntity(ManageServerEntity entity) {
    return ManageServerDTO(
      id: entity.id,
      name: entity.name,
      server: entity.server,
    );
  }
}
