// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'server.g.dart';

@HiveType(typeId: 1)
class Server extends Equatable {
  @HiveField(0)
  final String ip;
  @HiveField(1)
  final int port;
  const Server({
    required this.ip,
    required this.port,
  });

  @override
  List<Object> get props => [ip, port];

  String toAddress() {
    return "$ip:$port";
  }
}
