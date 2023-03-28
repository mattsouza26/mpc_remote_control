// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AppSettingsEntity {
  final bool isFirstOpening;
  final String themeModeName;
  final bool keepScreenOn;
  final bool notification;
  final bool useHardwareVolumeKeys;
  final bool incomingCall;
  final bool afterCallEnd;

  const AppSettingsEntity({
    required this.isFirstOpening,
    required this.themeModeName,
    required this.keepScreenOn,
    required this.notification,
    required this.useHardwareVolumeKeys,
    required this.incomingCall,
    required this.afterCallEnd,
  });
}
