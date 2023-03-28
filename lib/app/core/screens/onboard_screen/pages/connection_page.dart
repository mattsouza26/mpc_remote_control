import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(children: [
        Align(
          alignment: const Alignment(0, -0.9),
          child: Text(
            "CONNECTION",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All you need is:",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                "- configure MPC on a PC",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "(Options > Player > Web Interface)",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
              ),
              const SizedBox(height: 15),
              Image(
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
                image: AssetImage('lib/app/core/assets/images/onboard/${isDark ? 'connection_helper_dark.png' : 'connection_helper.png'}'),
              ),
              const SizedBox(height: 5),
              Text(
                "(don´t forget to set up a firewall exception)",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
