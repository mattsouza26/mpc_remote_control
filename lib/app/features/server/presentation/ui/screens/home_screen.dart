import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mpc_remote_control/app/features/server/presentation/ui/screens/widgets/controller_play_pause_button.dart';
import 'package:mpc_remote_control/app/features/server/presentation/ui/screens/widgets/media_status.dart';

import '../../../../../core/dialogs/app_about_dialog.dart';
import '../../../../../core/models/command.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../../../core/utils/commands_utils.dart';
import '../../../../../core/utils/screen_utils.dart';
import '../../../../settings/presentation/controller/settings_controller.dart';
import '../../controller/server_controller.dart';
import 'dialog/more_commands_dialog.dart';
import 'widgets/controller_button.dart';
import 'widgets/controller_media_button/controller_media_button.dart';
import 'widgets/controller_media_button/gesture_area.dart';
import 'widgets/controller_section.dart';
import 'widgets/controller_volume_button.dart';
part 'widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<_HomeAppBarState> _appBarKey = GlobalKey<_HomeAppBarState>();
  late final ServerController _serverController;
  late final SettingsController _settingsController;

  @override
  void initState() {
    _serverController = GetIt.I.get<ServerController>();
    _settingsController = GetIt.I.get<SettingsController>();
    _serverController.addListener(_updateSelectedServer);
    super.initState();
  }

  @override
  void dispose() {
    _serverController.removeListener(_updateSelectedServer);
    super.dispose();
  }

  void _sendCommand(Command command) {
    _serverController.sendCommand(command);
  }

  void _hideFlexibleAppBar() {
    _appBarKey.currentState?.hideFlexibleSpace();
  }

  void _updateSelectedServer() {
    setState(() {});
  }

  void _disconnect() {
    _serverController.disconnect();
  }

  void _showMoreCommands() {
    showDialog(
      context: context,
      builder: (context) => MoreCommandsDialog(
        commands: _settingsController.customControls.value,
        onPressed: _sendCommand,
      ),
    );
  }

  void _mediaVolumeController(Drag drag) async {
    final volume = _serverController.selected.mediaStatus?.volume.value;
    if (volume == null) return;
    final value = drag.value;

    final volumeBoost = (10 * value).round();
    late final int volumePorcent;
    if (drag.startDirection == DragVerticalDirection.up) {
      volumePorcent = ((volume + volumeBoost)).round();
    } else {
      volumePorcent = ((volume - volumeBoost)).round();
    }
    await _serverController.sendCommand(ControllerCommands.volume, volume: volumePorcent);
  }

  void _mediaSeekController(Drag drag) async {
    final position = _serverController.selected.mediaStatus?.position.value;
    final duration = _serverController.selected.mediaStatus?.duration.value;
    if (position == null && duration == null || position!.isInfinite || duration == 0) return;
    final double positionSec = position / 1000;
    final double durationSec = duration! / 1000;
    late final double seekPos;

    if (drag.startDirection == DragHorizontalDirection.right) {
      seekPos = positionSec + (5 * (drag.value * 6));
    } else {
      seekPos = positionSec - (5 * (drag.value * 6));
    }
    final porcent = ((seekPos / durationSec) * 100).round();
    await _serverController.sendCommand(ControllerCommands.seek, seek: porcent);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Size(ScreenUtils().screenSize(context).width, ScreenUtils().screenSize(context).height - ScreenUtils().navigationBarHeight(context));
    final padding = EdgeInsets.only(top: 0, left: (screenSize.width * 0.075).roundToDouble(), right: (screenSize.width * 0.075).roundToDouble(), bottom: 10);

    final buttonMargin = EdgeInsets.only(top: screenSize.height * 0.025);

    final middleButtonSize = (screenSize.height * 0.3).roundToDouble();
    final smallButtonSize = (middleButtonSize * 0.35).roundToDouble();
    final volumeButtonSize = (smallButtonSize * 2.25).roundToDouble();

    return GestureDetector(
      onTap: _hideFlexibleAppBar,
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            HomeAppBar(
              key: _appBarKey,
              expandedHeight: 200,
              flexibleSpace: AnimatedBuilder(
                  animation: Listenable.merge([
                    _serverController.selected.mediaStatus?.state,
                    _serverController.selected.mediaStatus?.position,
                    _serverController.selected.mediaStatus?.fileName,
                    _serverController.selected.mediaStatus?.volume,
                    _settingsController.fileExtension,
                  ]),
                  builder: (context, child) {
                    return MediaStatus(
                      selected: _serverController.selected,
                      showExtension: _settingsController.fileExtension.value,
                      onDisconnect: () => _disconnect(),
                    );
                  }),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                alignment: Alignment.center,
                padding: padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ControllerSection(
                      padding: const EdgeInsets.only(top: 5),
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ControllerButton(
                          size: smallButtonSize,
                          icon: Icons.skip_previous_rounded,
                          onPressed: () => _sendCommand(ControllerCommands.previous),
                          onLongPress: () => _sendCommand(ControllerCommands.previousFile),
                          isMultiAction: false,
                        ),
                        ControllerButton(
                          size: smallButtonSize,
                          icon: Icons.skip_next_rounded,
                          onPressed: () => _sendCommand(ControllerCommands.next),
                          onLongPress: () => _sendCommand(ControllerCommands.nextFile),
                          isMultiAction: false,
                        ),
                      ],
                    ),
                    ControllerSection(
                      padding: EdgeInsets.symmetric(vertical: smallButtonSize * 0.25),
                      children: [
                        ControllerMediaButton(
                          size: middleButtonSize,
                          onTap: () => _sendCommand(ControllerCommands.togglePlayPause),
                          onHorizontalDrag: _mediaSeekController,
                          onVerticalDrag: _mediaVolumeController,
                        ),
                      ],
                    ),
                    ControllerSection(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ControllerSection(
                          margin: buttonMargin,
                          children: [
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.fast_rewind_rounded,
                              onPressed: () => _sendCommand(ControllerCommands.jumpBackward(_settingsController.jumpDistance.value)),
                              onLongPress: () => _sendCommand(ControllerCommands.jumpBackward(_settingsController.jumpDistance.value)),
                            ),
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.audiotrack_rounded,
                              onPressed: () => _sendCommand(ControllerCommands.nextAudioTrack),
                            ),
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.closed_caption_rounded,
                              onPressed: () => _sendCommand(ControllerCommands.nextSubtitleTrack),
                              isMultiAction: false,
                              onLongPress: () => _sendCommand(ControllerCommands.toggleSubtitle),
                            )
                          ],
                        ),
                        ControllerSection(
                          startMargin: EdgeInsets.only(top: smallButtonSize * 0.7),
                          margin: buttonMargin,
                          children: [
                            AnimatedBuilder(
                              animation: Listenable.merge([_serverController.selected.mediaStatus?.state]),
                              builder: (context, child) {
                                return ControllerPlayPauseButton(
                                  size: smallButtonSize,
                                  state: _serverController.selected.mediaStatus?.state.value,
                                  onPressed: () => _sendCommand(ControllerCommands.togglePlayPause),
                                  onLongPress: () => _sendCommand(ControllerCommands.stop),
                                );
                              },
                            ),
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.fullscreen,
                              onPressed: () => _sendCommand(ControllerCommands.fulllscreen),
                            ),
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.more_horiz_rounded,
                              onPressed: () => _showMoreCommands(),
                            )
                          ],
                        ),
                        ControllerSection(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          margin: buttonMargin,
                          children: [
                            ControllerButton(
                              size: smallButtonSize,
                              icon: Icons.fast_forward_rounded,
                              onPressed: () => _sendCommand(ControllerCommands.jumpForward(_settingsController.jumpDistance.value)),
                              onLongPress: () => _sendCommand(ControllerCommands.jumpForward(_settingsController.jumpDistance.value)),
                            ),
                            ControllerVolumeButton(
                              size: volumeButtonSize,
                              onUpPress: () => _sendCommand(ControllerCommands.volumeUp),
                              onDownPress: () => _sendCommand(ControllerCommands.volumeDown),
                              onUpLongPress: () => _sendCommand(ControllerCommands.volumeUp),
                              onDownLongPress: () => _sendCommand(ControllerCommands.volumeDown),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
