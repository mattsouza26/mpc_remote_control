// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/models/server.dart';

abstract class ServerSettingsEntity {
  final String subnet;
  final List<int> ports;
  final Server? lastServer;
  final bool autoConnect;
  const ServerSettingsEntity({
    required this.subnet,
    required this.ports,
    this.lastServer,
    required this.autoConnect,
  });
}
