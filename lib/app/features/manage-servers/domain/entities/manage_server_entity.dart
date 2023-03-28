// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/models/server.dart';

class ManageServerEntity {
  final String id;
  final String name;
  final Server server;

  ManageServerEntity({
    required this.id,
    required this.name,
    required this.server,
  });
}
