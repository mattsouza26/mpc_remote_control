import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mpc_remote_control/app/core/routes/app_route.dart';
import 'package:mpc_remote_control/app/features/server/presentation/models/server_selected.dart';
import 'package:mpc_remote_control/app/features/server/presentation/ui/screens/widgets/controller_button.dart';

import '../../../../../../core/widgets/slide_animated_text/slide_animated_text.dart';

class MediaStatus extends StatelessWidget {
  final ServerSelected selected;
  final bool showExtension;
  final void Function()? onDisconnect;
  const MediaStatus({super.key, required this.selected, this.onDisconnect, required this.showExtension});

  String _fileName(String? value) {
    final fileName = value ?? "Nenhum Arquivo";
    if (!showExtension) {
      return fileName.substring(0, selected.mediaStatus?.fileName.value.lastIndexOf('.'));
    }
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(height: 2.5),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "State: ",
                style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: selected.state.name,
                style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 12),
              )
            ],
          ),
        ),
        if (selected.state != ServerState.disconnected)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Connected at: ",
                  style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: selected.server?.ip != null ? "${selected.server?.ip}:${selected.server?.port}" : "Desconnectado",
                  style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
        if (selected.state == ServerState.connected) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Loaded file: ",
                    style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SlideAnimatedText(
                      text: _fileName(selected.mediaStatus?.fileName.value),
                      blankSpace: 50,
                      startAfter: const Duration(seconds: 3),
                      pauseAfterRound: const Duration(seconds: 5),
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      velocity: 25,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Status: ",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: selected.mediaStatus?.state.value.name,
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Time: ",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "${selected.mediaStatus?.positionStr.value ?? "00:00:00"}/${selected.mediaStatus?.durationStr.value ?? "00:00:00"}",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Volume: ",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "${selected.mediaStatus?.volume.value ?? 0} %",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
        const Spacer(),
        if (selected.state != ServerState.disconnected)
          Align(
            alignment: Alignment.center,
            child: ControllerButton(
              icon: Icons.power_settings_new_outlined,
              size: 55,
              onPressed: onDisconnect,
            ),
          )
        else
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => context.pushNamed(AppRoute.manageServersScreen),
              child: const Text("Go to Manage Servers"),
            ),
          )
      ],
    );
  }
}
