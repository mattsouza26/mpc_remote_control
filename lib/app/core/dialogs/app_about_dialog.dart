import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppAboutDialog extends StatelessWidget {
  const AppAboutDialog({super.key});

  void _onTap() {
    launchUrl(Uri.parse("https://github.com/mattsouza26/mpc_remote_control"), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AlertDialog(
      content: ListBody(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconTheme(
                data: Theme.of(context).iconTheme,
                child: const Image(
                  height: 35,
                  image: AssetImage('lib/app/core/assets/images/app_icon.png'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListBody(
                    children: <Widget>[
                      Text('MPC Remote Control', style: themeData.textTheme.headlineSmall),
                      Text('1.0.0', style: themeData.textTheme.bodyMedium),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListBody(
              children: [
                const Text(
                  "This is my first Flutter app, and I'm excited to share it with you! This open-source project was developed as a way for me to learn more about Flutter and mobile app development.",
                ),
                const SizedBox(height: 5),
                const Text(
                  "As an open source project, you can view the source code for this App on GitHub. My hope is that this application will serve as a learning resource for other Flutter developers who are just starting out.",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CommunityMaterialIcons.github),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: _onTap,
                      child: const Text(
                        "Check on GitHub.",
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      scrollable: true,
    );
  }
}
