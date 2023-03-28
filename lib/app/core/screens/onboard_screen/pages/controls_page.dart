import 'package:flutter/material.dart';

class ControlsPage extends StatelessWidget {
  const ControlsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(children: [
        Center(
          child: Image(
            width: double.infinity,
            fit: BoxFit.fill,
            image: AssetImage("lib/app/core/assets/images/onboard/${isDark ? 'controls_helper_dark.png' : 'controls_helper.png'}"),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.85),
          child: Text(
            "CONTROLS",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ]),
    );
  }
}
