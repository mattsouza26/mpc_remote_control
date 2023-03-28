import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:mpc_remote_control/app/core/services/http_client/models/http_response.dart';

import '../../../../core/models/server.dart';
import '../../../../core/services/http_client/errors/http_client_exception.dart';
import '../../../../core/services/http_client/http_client_service.dart';
import '../../domain/entities/media_status_entity.dart';
import '../../domain/errors/server_connection_exception.dart';
import '../dto/media_status_dto.dart';
import '../dto/server_request_dto.dart';
import '../dto/server_response_dto.dart';

abstract class ServerDataSource {
  Future<ServerResponseDTO> sendCommand(ServerRequestDTO request);
  Future<MediaStatusDTO> getMediaStatus(Server server);
  Future<ServerResponseDTO> checkServer(Server server);
}

class ServerDataSourceImpl implements ServerDataSource {
  final HttpClientService _httpService;

  ServerDataSourceImpl(this._httpService);

  @override
  Future<MediaStatusDTO> getMediaStatus(Server server) async {
    try {
      HttpClientResponse response = await _httpService.get("http://${server.ip}:${server.port}/variables.html", timeout: const Duration(seconds: 2));

      if (response.statusCode != 200) throw const ServerException();
      Document document = parse(response.data);
      Element? variables = document.querySelector(".page-variables");

      if (variables == null) throw const ServerException("Unable to parse media status from the server");
      final variablesMap = _variablesToMap(variables);
      return MediaStatusDTO.fromMap(variablesMap);
    } on SocketException catch (e) {
      throw ServerException(e.toString());
    } on HttpClientException catch (e) {
      throw ServerException(e.error);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ServerResponseDTO> sendCommand(ServerRequestDTO request) async {
    try {
      final Server server = request.server;
      final int command = request.command.cod;
      final int? volume = request.volume;
      final int? seek = request.seek;
      final response = await _httpService.post(
        "http://${server.ip}:${server.port}/command.html?wm_command=$command${volume != null ? '&volume=$volume' : ''}${seek != null ? '&percent=$seek%' : ''}",
        timeout: const Duration(seconds: 1),
      );
      if (response.statusCode != 200) throw const ServerException('Server maybe not avaible');
      return ServerResponseDTO(server: server, command: request.command, message: "Command sent successfully");
    } on HttpClientException catch (e) {
      throw ServerException(e.error);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ServerResponseDTO> checkServer(Server server) async {
    try {
      final response = await _httpService.post("http://${server.ip}:${server.port}/command.html?wm_command=-1", timeout: const Duration(seconds: 1));
      if (response.statusCode != 200) throw const ServerException('Server maybe not avaible');
      return ServerResponseDTO(server: server, message: "Server is Online");
    } on HttpClientException catch (e) {
      throw ServerException(e.error);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Map<String, dynamic> _variablesToMap(Element variables) {
    return {
      'fileName': variables.querySelector("#file")!.text,
      'filePath': variables.querySelector("#filepath")!.text,
      'filePathArg': variables.querySelector("#filepatharg")!.text,
      'fileDir': variables.querySelector("#filedir")!.text,
      'fileDirArg': variables.querySelector("#filedirarg")!.text,
      'state': FileState.values.firstWhere((state) => "${state.code}" == variables.querySelector("#state")!.text, orElse: () => FileState.notReproducing),
      'position': int.tryParse(variables.querySelector("#position")!.text),
      'positionStr': variables.querySelector("#positionstring")?.text,
      'duration': int.tryParse(variables.querySelector("#duration")!.text),
      'durationStr': variables.querySelector("#durationstring")!.text,
      'volume': int.tryParse(variables.querySelector("#volumelevel")!.text),
      'muted': variables.querySelector("#muted")!.text == '0' ? true : false,
    };
  }
}
