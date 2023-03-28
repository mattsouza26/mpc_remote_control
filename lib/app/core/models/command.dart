// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'command.g.dart';

@HiveType(typeId: 2)
class Command extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int cod;
  const Command({
    required this.name,
    required this.cod,
  });

  @override
  List<Object?> get props => [name, cod];
}
