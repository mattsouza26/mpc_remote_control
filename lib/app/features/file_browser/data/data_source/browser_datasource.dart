import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../../../core/models/server.dart';
import '../../../../core/services/http_client/http_client_service.dart';
import '../../domain/entities/browser_entity.dart';
import '../../domain/errors/file_browser_exception.dart';
import '../dto/browser_dto.dart';

abstract class BrowserDataSource {
  Future<BrowserDTO> getFiles(Server server);
  Future<void> openFile(Server server, String path);
  Future<BrowserDTO> openFolder(Server server, String path);
}

class BrowserDataSourceImpl implements BrowserDataSource {
  final HttpClientService _service;

  BrowserDataSourceImpl(this._service);

  @override
  Future<BrowserDTO> getFiles(Server server) async {
    try {
      final response = await _service.get("http://${server.ip}:${server.port}/browser.html", timeout: const Duration(seconds: 4));
      if (response.statusCode != 200) throw const FileBrowserException("Server is disconnected!");
      Document document = parse(response.data);
      List<Element> tables = document.querySelectorAll(".browser-table");

      if (tables.isEmpty) throw const FileBrowserException("Couldn't parse files list!");
      final List<FileDTO> files = [];
      final String? currentPath = RegExp(r'(?<=Location: ).*').stringMatch(tables.first.text);

      for (Element column in tables.last.getElementsByTagName("tr")) {
        if (column.getElementsByTagName("th").isEmpty) {
          final Map<String, dynamic> file = {
            'name': column.getElementsByTagName("td")[0].querySelector("a")!.text,
            'path': RegExp(r'(?<=path=).*').stringMatch(column.getElementsByTagName("td")[0].querySelector("a")!.attributes['href']!),
            'type': FileType.getFileType(column.getElementsByTagName("td")[1].text),
          };
          files.add(FileDTO.fromMap(file));
        }
      }

      if (currentPath == null && files.isEmpty) throw const FileBrowserException("Couldn't find any file!");

      return BrowserDTO(path: currentPath!.substring(0, currentPath.lastIndexOf(r'\')), files: files);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> openFile(Server server, String path) async {
    try {
      final response = await _service.post("http://${server.ip}:${server.port}/browser.html?path=$path", timeout: const Duration(seconds: 4));
      if (response.statusCode != 200) throw const FileBrowserException("Server is disconnected!");
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BrowserDTO> openFolder(Server server, String path) async {
    try {
      final response = await _service.get("http://${server.ip}:${server.port}/browser.html?path=$path", timeout: const Duration(seconds: 4));
      if (response.statusCode != 200) throw const FileBrowserException("Server is disconnected!");
      Document document = parse(response.data);
      List<Element> tables = document.querySelectorAll(".browser-table");

      if (tables.isEmpty) throw const FileBrowserException("Couldn't parse files list!");
      final List<FileDTO> files = [];
      final String? currentPath = RegExp(r'(?<=Location: ).*').stringMatch(tables.first.text);

      for (Element column in tables.last.getElementsByTagName("tr")) {
        if (column.getElementsByTagName("th").isEmpty) {
          final Map<String, dynamic> file = {
            'name': column.getElementsByTagName("td")[0].querySelector("a")!.text,
            'path': RegExp(r'(?<=path=).*').stringMatch(column.getElementsByTagName("td")[0].querySelector("a")!.attributes['href']!),
            'type': FileType.getFileType(column.getElementsByTagName("td")[1].text),
          };
          files.add(FileDTO.fromMap(file));
        }
      }

      if (currentPath == null && files.isEmpty) throw const FileBrowserException("Couldn't find any file!");

      return BrowserDTO(path: currentPath!.substring(0, currentPath.lastIndexOf(r'\')), files: files);
    } catch (e) {
      rethrow;
    }
  }
}
