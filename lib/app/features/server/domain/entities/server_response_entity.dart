// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/models/command.dart';
import '../../../../core/models/server.dart';

class ServerResponseEntity {
  final Server server;
  final Command? command;
  final String? message;

  const ServerResponseEntity({
    required this.server,
    this.command,
    this.message,
  });
}
