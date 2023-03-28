// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mpc_remote_control/app/core/models/command.dart';

abstract class ControlSettingsEntity {
  final String jumpDistance;
  final List<Command> customControls;
  const ControlSettingsEntity({
    required this.jumpDistance,
    required this.customControls,
  });
}
