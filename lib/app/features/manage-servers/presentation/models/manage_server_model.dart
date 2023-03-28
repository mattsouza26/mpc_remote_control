import '../../../../core/models/server.dart';
import '../../data/dto/manage_server_dto.dart';

class ManageServerModel extends ManageServerDTO {
  ManageServerModel({
    required String id,
    required String name,
    required Server server,
  }) : super(
          id: id,
          name: name,
          server: server,
        );
}
