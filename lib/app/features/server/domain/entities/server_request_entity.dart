// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/models/command.dart';
import '../../../../core/models/server.dart';

class ServerRequestEntity {
  final Server server;
  final Command command;
  final int? volume;
  final int? seek;

  const ServerRequestEntity({
    required this.server,
    required this.command,
    this.volume,
    this.seek,
  });
}
