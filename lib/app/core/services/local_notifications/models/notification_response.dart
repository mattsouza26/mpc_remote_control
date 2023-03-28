// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

class LocalNotificationResponse implements TransferableTypedData {
  final int? id;
  final String? actionId;
  final String? input;
  final Map<String, dynamic>? payload;
  final String? notificationResponseType;

  LocalNotificationResponse({
    this.id,
    this.actionId,
    this.input,
    this.payload,
    this.notificationResponseType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'actionId': actionId,
      'input': input,
      'payload': payload,
      'notificationResponseType': notificationResponseType,
    };
  }

  factory LocalNotificationResponse.fromMap(Map<String, dynamic> map) {
    return LocalNotificationResponse(
      id: map['id'],
      actionId: map['actionId'],
      input: map['input'],
      payload: map['payload'],
      notificationResponseType: map['notificationResponseType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalNotificationResponse.fromJson(String source) => LocalNotificationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  ByteBuffer materialize() {
    final responseJson = json.encode(this);
    final responseBytes = utf8.encode(responseJson);
    final buffer = Uint8List.fromList(responseBytes).buffer;

    return buffer;
  }

  TransferableTypedData toTransferableTypeData() {
    final responseJson = json.encode(this);
    final responseBytes = utf8.encode(responseJson);
    final buffer = Uint8List.fromList(responseBytes).buffer;
    return TransferableTypedData.fromList([Uint8List.view(buffer)]);
  }
}
